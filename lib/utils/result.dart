// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

typedef FutureResult<T> = Future<Result<T>>;
typedef FutureResultVoid = Future<Result<void>>;

sealed class Result<T> {
  const Result();
  const factory Result.ok(T value) = Ok._;

  const factory Result.error(Exception error) = Error._;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

final class Error<T> extends Result<T> {
  const Error._(this.error);
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}