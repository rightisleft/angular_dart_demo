import 'package:dartson/type_transformer.dart';

class DateTimeParser<T> extends TypeTransformer {
  T decode(dynamic value) {
    return DateTime.parse(value);
  }

  dynamic encode(T value) {
    return value.toString();
  }
}

class ObjectIdParser<T> extends TypeTransformer {
  T decode(dynamic value) {
    return value.toString();
  }

  dynamic encode(T value) {
    return value.toString();
  }
}
