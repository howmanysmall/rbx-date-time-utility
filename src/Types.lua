--!optimize 2
export type DateTimeFormatInfo = {
	Preset: {
		da: DateTimeFormatInfo,
		de: DateTimeFormatInfo,
		en: DateTimeFormatInfo,
		en_001: DateTimeFormatInfo,
		es: DateTimeFormatInfo,
		es_419: DateTimeFormatInfo,
		fr: DateTimeFormatInfo,
		ja: DateTimeFormatInfo,
	},

	StandaloneMonthNames: {string},
	StandaloneDayNames: {string},
	MonthNames: {string},
	DayNames: {string},
	AbbreviatedStandaloneMonthNames: {string},
	AbbreviatedStandaloneDayNames: {string},
	AbbreviatedMonthNames: {string},
	AbbreviatedDayNames: {string},

	AMDesignator: string,
	PMDesignator: string,

	DateSeparator: string,
	TimeSeparator: string,

	ShortDatePattern: string,
	LongDatePattern: string,
	ShortTimePattern: string,
	LongTimePattern: string,
	FullDateTimePattern: string,
	MonthDayPattern: string,
	YearMonthPattern: string,

	FirstDayOfWeek: string,

	ReadOnly: boolean,

	Clone: (self: DateTimeFormatInfo) -> DateTimeFormatInfo,
}

export type DateTime2 = {
	Year: number,
	Month: number,
	Day: number,
	Hour: number,
	Minute: number,
	Second: number,
	Millisecond: number,
	Weekday: number,
	Ordinal: number,
	TimeOfDay: TimeSpan,

	AddMilliseconds: (self: DateTime2, Value: number) -> DateTime2,
	AddSeconds: (self: DateTime2, Value: number) -> DateTime2,
	AddMinutes: (self: DateTime2, Value: number) -> DateTime2,
	AddHours: (self: DateTime2, Value: number) -> DateTime2,
	AddDays: (self: DateTime2, Value: number) -> DateTime2,
	AddMonths: (self: DateTime2, Value: number) -> DateTime2,
	AddYears: (self: DateTime2, Value: number) -> DateTime2,

	ISO8601: (self: DateTime2, Separator: string?) -> string,
	RFC2822: (self: DateTime2) -> string,
	ctime: (self: DateTime2) -> string,

	Epoch: (self: DateTime2) -> number,
	EpochMilliseconds: (self: DateTime2) -> number,
	OsDate: (self: DateTime2) -> typeof(os.date("!*t")),

	Format: (self: DateTime2, Format: string, FormatInfo: DateTimeFormatInfo?) -> string,
}

export type TimeSpanFormatInfo = {
	Preset: {
		da: TimeSpanFormatInfo,
		de: TimeSpanFormatInfo,
		en: TimeSpanFormatInfo,
		ja: TimeSpanFormatInfo,
	},

	TimeSeparator: string,
	MillisecondSeparator: string,
	DayHourMinuteSecondPattern: string,
	HourMinuteSecondPattern: string,
	HourMinuteSecondMillisecondPattern: string,
	MinuteSecondPattern: string,
	MinuteSecondMillisecondPattern: string,
	SecondMillisecondPattern: string,
	AbbreviatedDayHourMinuteSecondPattern: string,
	AbbreviatedHourMinuteSecondPattern: string,
	AbbreviatedHourMinuteSecondMillisecondPattern: string,
	AbbreviatedMinuteSecondPattern: string,
	AbbreviatedMinuteSecondMillisecondPattern: string,
	AbbreviatedSecondMillisecondPattern: string,
	FullDayHourMinuteSecondPattern: string,
	FullHourMinuteSecondPattern: string,
	FullHourMinuteSecondMillisecondPattern: string,
	FullMinuteSecondPattern: string,
	FullMinuteSecondMillisecondPattern: string,
	FullSecondMillisecondPattern: string,

	ReadOnly: boolean,

	Clone: (self: TimeSpanFormatInfo) -> TimeSpanFormatInfo,
}

export type TimeSpan = {
	TotalDays: number,
	TotalHours: number,
	TotalMinutes: number,
	TotalSeconds: number,
	TotalMilliseconds: number,
	Days: number,
	Hours: number,
	Minutes: number,
	Seconds: number,
	Milliseconds: number,

	Format: (self: TimeSpan, Format: string, FormatInfo: TimeSpanFormatInfo?) -> string,
}

return false
