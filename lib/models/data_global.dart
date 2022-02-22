class GlobalData{
  final int updatedConfirmed;
  final int updatedTotalConfirmed;
  final int updatedDeaths;
  final int updatedTotalDeaths;
  final int updatedNewRecoveries;
  final int updatedTotalRecoveries;
  final DateTime date;

  GlobalData(this.updatedConfirmed, this.updatedTotalConfirmed, this.updatedDeaths, this.updatedTotalDeaths, this.updatedNewRecoveries, this.updatedTotalRecoveries, this.date);

  factory GlobalData.fromJson(Map<String, dynamic> json){
    return GlobalData(
      json['Global']['NewConfirmed'], 
      json['Global']['TotalConfirmed'], 
      json['Global']['NewDeaths'], 
      json['Global']['TotalDeaths'], 
      json['Global']['NewRecovered'],
      json['Global']['TotalRecovered'],
      DateTime.parse(json['Date']),
      );
  }
}