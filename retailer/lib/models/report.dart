class ProductReport {
  final String pid;
  final String name;
  int qty;

  ProductReport({
    required this.pid,
    required this.name,
    required this.qty,
  });
}

class Report {
  final String torder;
  final int pending;
  final int accepted;
  final int completed;
  final List<ProductReport> prodrep;

  Report({
    required this.torder,
    required this.pending,
    required this.accepted,
    required this.completed,
    required this.prodrep,
  });
}
