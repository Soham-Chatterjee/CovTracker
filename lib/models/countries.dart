class Countries{
  final String country;
  final String slug;
  final String iso2;

  Countries(this.country, this.slug, this.iso2);

  factory Countries.fromJson(Map<String, dynamic> json){
    return Countries(
      json['Country'],
      json['Slug'], 
      json['ISO2'],
    );
  }
}