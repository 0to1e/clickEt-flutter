import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:ClickEt/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockAuthRepository extends Mock implements IAuthRepository {}

class MockFailure {
  final String message;
  MockFailure(this.message);
}

void main() {
  late ProfileBloc profileBloc;
  late MockAuthRepository mockAuthRepository;

  // Sample AuthEntity for testing
  const authEntity = AuthEntity(
    userName: 'testUser',
    profileURL: 'http://example.com/old.jpg',
    fullName: 'test user',
    phoneNumber: "98651456234",
    email: "jalkj@jgal.jljs",
    password: "Password123"
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    profileBloc = ProfileBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    profileBloc.close();
  });

  group('ProfileBloc', () {
    // Test FetchUserEvent
    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileLoaded] when FetchUserEvent succeeds',
      build: () {
        when(() => mockAuthRepository.getUserStatus())
            .thenAnswer((_) async => const Right(authEntity));
        return profileBloc;
      },
      act: (bloc) => bloc.add(FetchUserEvent()),
      expect: () => [
        ProfileLoading(),
        const ProfileLoaded(authEntity),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.getUserStatus()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileError] when FetchUserEvent fails',
      build: () {
        when(() => mockAuthRepository.getUserStatus()).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Fetch failed')));
        return profileBloc;
      },
      act: (bloc) => bloc.add(FetchUserEvent()),
      expect: () => [
        ProfileLoading(),
        const ProfileError('Fetch failed'),
      ],
    );

    // Test LogoutEvent
    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoggedOut] when LogoutEvent succeeds',
      build: () {
        when(() => mockAuthRepository.logout())
            .thenAnswer((_) async => const Right(null));
        return profileBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [
        ProfileLoggedOut(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.logout()).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileError] when LogoutEvent fails',
      build: () {
        when(() => mockAuthRepository.logout()).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Logout failed')));
        return profileBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [
        const ProfileError('Logout failed'),
      ],
    );

    // Test DeleteAccountEvent
    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileDeleted] when DeleteAccountEvent succeeds and state is ProfileLoaded',
      build: () {
        when(() => mockAuthRepository.deleteUser(any()))
            .thenAnswer((_) async => const Right(null));
        profileBloc.emit(const ProfileLoaded(authEntity)); // Set initial state
        return profileBloc;
      },
      act: (bloc) => bloc.add(DeleteAccountEvent()),
      expect: () => [
        ProfileDeleted(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.deleteUser('testUser')).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileError] when DeleteAccountEvent fails',
      build: () {
        when(() => mockAuthRepository.deleteUser(any())).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Delete failed')));
        profileBloc.emit(const ProfileLoaded(authEntity)); // Set initial state
        return profileBloc;
      },
      act: (bloc) => bloc.add(DeleteAccountEvent()),
      expect: () => [
        const ProfileError('Delete failed'),
      ],
    );
  });
}
