
class ItemsLawsuitSentence {
  String DecidedCase;
  String UndecidedCase;
  String CourtName;
  String SentenceDate;
  double FineValue;
  String FineType;
  String FineDate;
  bool IsOneTime;
  bool IsPeriod;
  int Period;
  int PeriodNum;
  int Imprison;
  String ImprisonType;
  bool IsFine;
  bool IsImprison;
  bool IsDismissed;

  ItemsLawsuitSentence(this.DecidedCase,
      this.UndecidedCase,
      this.CourtName,
      this.SentenceDate,
      this.FineValue,
      this.FineType,
      this.FineDate,
      this.IsOneTime,
      this.IsPeriod,
      this.PeriodNum,
      this.Period,
      this.Imprison,
      this.ImprisonType,
      this.IsFine,
      this.IsImprison,
      this.IsDismissed,
      );
}