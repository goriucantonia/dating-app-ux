import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';
import 'models.dart';

/// The A1 form in three short steps: account → about you → who you're
/// looking for (new_user_creation.md §1, S4-U3). Client-side validation
/// mirrors every server CHECK so errors land at the field, not after submit.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  int _step = 0;
  final _stepKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _displayName = TextEditingController();
  final _city = TextEditingController();
  final _country = TextEditingController();
  DateTime? _birthDate;
  String? _gender;
  final Set<String> _interestedIn = {};
  RangeValues _agePref = const RangeValues(18, 45);
  bool _optIn = false; // default OFF (A1)

  String? _serverError;
  bool _busy = false;

  @override
  void dispose() {
    for (final c in [_email, _password, _displayName, _city, _country]) {
      c.dispose();
    }
    super.dispose();
  }

  bool _validateStep() {
    switch (_step) {
      case 0:
        return _stepKeys[0].currentState!.validate();
      case 1:
        final formOk = _stepKeys[1].currentState!.validate();
        if (_birthDate == null || _gender == null) {
          setState(() {}); // re-render to show the hint texts
          return false;
        }
        return formOk;
      case 2:
        if (_interestedIn.isEmpty) {
          setState(() {});
          return false;
        }
        return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (!_validateStep()) return;
    setState(() {
      _busy = true;
      _serverError = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).registerAccount(
            RegisterData(
              email: _email.text.trim(),
              password: _password.text,
              displayName: _displayName.text.trim(),
              birthDate: _birthDate!,
              gender: _gender!,
              interestedIn: _interestedIn.toList(),
              agePrefMin: _agePref.start.round(),
              agePrefMax: _agePref.end.round(),
              city: _city.text.trim(),
              country: _country.text.trim(),
              optIn: _optIn,
            ),
          );
      // Router redirect lands the signed-in user on '/'.
    } on ApiException catch (e) {
      setState(() => _serverError = e.message); // envelope message, verbatim
    } catch (_) {
      // A failure that is not the server's envelope must still be VISIBLE —
      // a silent catch here is how a tap does nothing (DEFECTS.md D-005).
      setState(() =>
          _serverError = 'Something went wrong on this device. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // The date picker itself cannot choose an under-18 birth date (AC2's
    // client-side half); the server rejection remains the one that counts.
    final latestAdultBirthDate =
        DateTime.now().subtract(const Duration(days: 18 * 365 + 5));

    return Scaffold(
      appBar: AppBar(title: const Text('Create your account')),
      body: LayoutShell(
        child: Stepper(
          currentStep: _step,
          type: StepperType.horizontal,
          onStepContinue: () {
            if (_step < 2) {
              if (_validateStep()) setState(() => _step++);
            } else {
              _submit();
            }
          },
          onStepCancel: _step == 0
              ? () => context.go('/login')
              : () => setState(() => _step--),
          controlsBuilder: (context, details) => Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                FilledButton(
                  onPressed: _busy ? null : details.onStepContinue,
                  child: Text(_step == 2 ? 'Create account' : 'Next'),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text(_step == 0 ? 'Back to sign in' : 'Back'),
                ),
              ],
            ),
          ),
          steps: [
            Step(
              title: const Text('Account'),
              isActive: _step >= 0,
              content: Form(
                key: _stepKeys[0],
                child: Column(
                  children: [
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        final t = v?.trim() ?? '';
                        if (!t.contains('@') || !t.split('@').last.contains('.')) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        helperText: 'At least 8 characters',
                      ),
                      obscureText: true,
                      validator: (v) => (v == null || v.length < 8)
                          ? 'At least 8 characters'
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            Step(
              title: const Text('About you'),
              isActive: _step >= 1,
              content: Form(
                key: _stepKeys[1],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _displayName,
                      decoration: const InputDecoration(labelText: 'Name'),
                      maxLength: 50,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'What should we call you?'
                          : null,
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_birthDate == null
                          ? 'Birth date'
                          : 'Born ${_birthDate!.year}-${_birthDate!.month.toString().padLeft(2, '0')}-${_birthDate!.day.toString().padLeft(2, '0')}'),
                      subtitle: _birthDate == null && _step == 1
                          ? Text('Required — you must be 18 or older',
                              style: TextStyle(color: theme.colorScheme.error))
                          : const Text('You must be 18 or older'),
                      trailing: const Icon(Icons.calendar_month),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: latestAdultBirthDate,
                          firstDate: DateTime(1920),
                          lastDate: latestAdultBirthDate,
                        );
                        if (picked != null) setState(() => _birthDate = picked);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text('I am a…', style: theme.textTheme.labelLarge),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final g in genderValues)
                          ChoiceChip(
                            label: Text(g),
                            selected: _gender == g,
                            onSelected: (_) => setState(() => _gender = g),
                          ),
                      ],
                    ),
                    if (_gender == null && _step == 1)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('Pick one',
                            style: TextStyle(
                                color: theme.colorScheme.error, fontSize: 12)),
                      ),
                  ],
                ),
              ),
            ),
            Step(
              title: const Text('Looking for'),
              isActive: _step >= 2,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Interested in…', style: theme.textTheme.labelLarge),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final g in genderValues)
                        FilterChip(
                          label: Text(g),
                          selected: _interestedIn.contains(g),
                          onSelected: (sel) => setState(() =>
                              sel ? _interestedIn.add(g) : _interestedIn.remove(g)),
                        ),
                    ],
                  ),
                  if (_interestedIn.isEmpty && _step == 2)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Pick at least one',
                          style: TextStyle(
                              color: theme.colorScheme.error, fontSize: 12)),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    'Age range: ${_agePref.start.round()}–${_agePref.end.round()}',
                    style: theme.textTheme.labelLarge,
                  ),
                  RangeSlider(
                    values: _agePref,
                    min: 18,
                    max: 80,
                    divisions: 62,
                    labels: RangeLabels('${_agePref.start.round()}',
                        '${_agePref.end.round()}'),
                    onChanged: (v) => setState(() => _agePref = v),
                  ),
                  TextFormField(
                    controller: _city,
                    decoration:
                        const InputDecoration(labelText: 'City (optional)'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _country,
                    decoration:
                        const InputDecoration(labelText: 'Country (optional)'),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Let others match with me'),
                    subtitle: const Text(
                        'Friends searching for a match can be paired with you. Off by default — change it anytime in Settings.'),
                    value: _optIn,
                    onChanged: (v) => setState(() => _optIn = v),
                  ),
                  if (_serverError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(_serverError!,
                          style: TextStyle(color: theme.colorScheme.error)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
