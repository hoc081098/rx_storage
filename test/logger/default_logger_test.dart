import 'package:rx_storage/rx_storage.dart';
import 'package:test/test.dart';

void main() {
  group('DefaultLogger<String, void>', () {
    final logger = DefaultLogger<String, void>();

    test('KeysChangedEvent', () {
      const pairs = [
        KeyAndValue('key1', 'value1'),
        KeyAndValue('key2', 2),
      ];

      expect(
        () => logger.log(KeysChangedEvent(pairs)),
        prints([
          ' ↓ Key changes',
          "    → { 'key1': value1 }",
          "    → { 'key2': 2 }\n",
        ].join('\n')),
      );
      ;
    });

    test('OnDataStreamEvent', () {
      const pair = KeyAndValue('key1', 'value1');
      expect(
        () => logger.log(OnDataStreamEvent(pair)),
        prints(" → Stream emits data: { 'key1': value1 }\n"),
      );
    });

    test('OnErrorStreamEvent', () {
      final stackTrace = StackTrace.current;
      final exception = Exception();
      expect(
        () => logger
            .log(OnErrorStreamEvent(RxStorageError(exception, stackTrace))),
        prints(' → Stream emits error: $exception, $stackTrace\n'),
      );
    });

    test('ReadValueSuccessEvent', () {
      const type = String;
      const key = 'key';
      const value = 'value';
      expect(
        () => logger
            .log(ReadValueSuccessEvent(KeyAndValue(key, value), type, null)),
        prints(" → Read: type=String, key='key' → value\n"),
      );
    });

    test('WriteSuccessEvent', () {
      const type = String;
      const key = 'key';
      const value = 'value';
      expect(
        () =>
            logger.log(WriteSuccessEvent(KeyAndValue(key, value), type, null)),
        prints(" ← Write: key='key', value=value, type=String → success\n"),
      );
    });
  });
}
