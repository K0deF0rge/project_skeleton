class SupabaseFilter {
  final String field;
  final FilterOperator operator;
  final dynamic value;
  SupabaseFilter(this.field, this.operator, this.value);
}

class Filter {
  final List<SupabaseFilter> _filters = [];
  List<SupabaseFilter> get filters => _filters;

  void addfilter(SupabaseFilter value) => _filters.add(value);
  void removeFilter(SupabaseFilter value) => _filters.remove(value);
  void clearFilters() => _filters.clear();
}

enum FilterOperator {
  eq('eq', 'Igual a'),
  neq('neq', 'Diferente de'),
  gt('gt', 'Maior que'),
  gte('gte', 'Maior ou igual a'),
  lt('lt', 'Menor que'),
  lte('lte', 'Menor ou igual a'),
  like('like', 'Corresponde ao padrão (case sensitive)'),
  ilike('ilike', 'Corresponde ao padrão (case insensitive)'),
  is_('is', 'É nulo ou não nulo'),
  inList('in', 'Está em uma lista de valores'),
  contains('cs', 'Contém (array ou texto)'),
  containedBy('cd', 'Está contido por (array ou texto)'),
  rangeGt('sr', 'Range maior que'),
  rangeGte('nxl', 'Range maior ou igual'),
  rangeLt('sl', 'Range menor que'),
  rangeLte('nxr', 'Range menor ou igual'),
  rangeAdjacent('adj', 'Range adjacente'),
  rangeOverlap('ov', 'Range sobreposto');

  final String value;
  final String description;
  const FilterOperator(this.value, this.description);
}