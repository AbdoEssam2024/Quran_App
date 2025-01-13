class AppApiLinks {
  // ================== Server Link ============= //
  static String server = "https://mp3quran.net/api";
  // =========== Moshaf Full Audio ============== //
  static String moshafFullAudio = "$server/v3/reciters";
  // ======= Surah Name + Page Numbers ========== //
  static String surahNameAndPageNumber = "$server/v3/suwar";
  // ============ Various readings ============== //
  static String variousReadingsAudio = "$server/v3/recent_reads";
  // ========= Eltabrey Explain Audio =========== //
  static String eltabryExplainAudio = "$server/v3/tafsir";
  // ========== Pondering The Quran Video  ============ //
  static String ponderingTheQuranVideo = "$server/v3/tadabor";
  // =========== The Best Readings Video  ============= //
  static String theBestReadingVideo = "$server/v3/videos";
  // =========== Salah Timing  ============= //
  static String salahTiming =
      "https://api.aladhan.com/v1/timingsByCity/08-01-2025?city=cairo&country=egypt&method=8";
}
