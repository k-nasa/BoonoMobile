import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mockito/mockito.dart';

const String _b64Image =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=';

final List<int> _image = base64.decode(_b64Image);

class _MockHttpClient extends Mock implements HttpClient {}

class _MockHttpClientRequest extends Mock implements HttpClientRequest {}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {}

class _MockHttpHeaders extends Mock implements HttpHeaders {}

_MockHttpClient createMockImageHttpClient(SecurityContext _) {
  final client = _MockHttpClient();
  final request = _MockHttpClientRequest();
  final response = _MockHttpClientResponse();
  final headers = _MockHttpHeaders();

  when(client.getUrl(any))
      .thenAnswer((_) => Future<HttpClientRequest>.value(request));

  when(request.headers).thenReturn(headers);
  when(request.close())
      .thenAnswer((_) => Future<HttpClientResponse>.value(response));
  when(response.contentLength).thenReturn(_image.length);
  when(response.statusCode).thenReturn(200);
  when(response.listen(any)).thenAnswer((Invocation invocation) {
  final void Function(List<int>) onData = invocation.positionalArguments[0];
  final void Function() onDone = invocation.namedArguments[#onDone];
  final void Function(Object, [StackTrace]) onError =
  invocation.namedArguments[#onError];
  final bool cancelOnError = invocation.namedArguments[#cancelOnError];
  return Stream<List<int>>.fromIterable(<List<int>>[_image]).listen(onData,
  onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  });
  return client;
}