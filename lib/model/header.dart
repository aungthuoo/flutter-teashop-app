import 'package:equatable/equatable.dart';

class Header extends Equatable {
  final int id;
  final double total;
  final double service_charges;
  final double total_packaging;
  final double tax;
  final double sub_total;

  Header(
      {this.id,
      this.total,
      this.service_charges,
      this.total_packaging,
      this.tax,
      this.sub_total});

  Header copyWith(
      {int id,
      int total,
      int service_charges,
      String total_packaging,
      String tax,
      String sub_total}) {
    return Header(
        id: id ?? this.id,
        total: total ?? this.total,
        service_charges: service_charges ?? this.service_charges,
        total_packaging: total_packaging ?? this.total_packaging,
        tax: tax ?? this.tax,
        sub_total: sub_total ?? this.sub_total);
  }

  @override
  List<Object> get props => [
        id,
        total,
        service_charges,
        total_packaging,
        tax,
        sub_total
      ];

  @override
  String toString() => 'Post { id: $id }';

  Map<String, dynamic> toJson() => _dimensionsToJson(this);
  Map<String, dynamic> _dimensionsToJson(Header header) =>
      <String, dynamic>{
        'id': header.id,
        'total': header.total,
        'service_charges': header.service_charges,
        'total_packaging': header.total_packaging,
        'tax': header.tax,
        'sub_total': header.sub_total
      };
}
