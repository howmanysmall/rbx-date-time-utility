declare enum EnumDayOfWeek {
	Monday = 1,
	Tuesday = 2,
	Wednesday = 3,
	Thursday = 4,
	Friday = 5,
	Saturday = 6,
	Sunday = 7,
}

interface DateTimeFormatInfo {
	StandaloneMonthNames: Array<string>;
	StandaloneDayNames: Array<string>;
	MonthNames: Array<string>;
	DayNames: Array<string>;
	AbbreviatedStandaloneMonthNames: Array<string>;
	AbbreviatedStandaloneDayNames: Array<string>;
	AbbreviatedMonthNames: Array<string>;
	AbbreviatedDayNames: Array<string>;

	AMDesignator: string;
	PMDesignator: string;

	DateSeparator: string;
	TimeSeparator: string;

	ShortDatePattern: string;
	LongDatePattern: string;
	ShortTimePattern: string;
	LongTimePattern: string;
	FullDateTimePattern: string;
	MonthDayPattern: string;
	YearMonthPattern: string;

	FirstDayOfWeek: EnumDayOfWeek;

	ReadOnly: boolean;

	Clone(): DateTimeFormatInfo;
}

interface DateTimeFormatInfoConstructor {
	new (parameters: Partial<Omit<DateTimeFormatInfo, "Clone">>): DateTimeFormatInfo;
	EnumDayOfWeek: EnumDayOfWeek;
	Preset: {
		da: DateTimeFormatInfo;
		de: DateTimeFormatInfo;
		en: DateTimeFormatInfo;
		en_001: DateTimeFormatInfo;
		es: DateTimeFormatInfo;
		es_419: DateTimeFormatInfo;
		fr: DateTimeFormatInfo;
		ja: DateTimeFormatInfo;
	};
}

interface DateTime2 {
	Year: number;
	Month: number;
	Day: number;
	Hour: number;
	Minute: number;
	Second: number;
	Millisecond: number;
	Weekday: number;
	Ordinal: number;
	JsWeekday: number;
	TimeOfDay: TimeSpan;

	Add(timeSpan: TimeSpan): DateTime2;
	Sub(dateTime: DateTime2): TimeSpan;
	Sub(timeSpan: TimeSpan): DateTime2;

	/**
	 * Behaves like DateTime2 < DateTime2.
	 * @param dateTime
	 */
	LessThan(dateTime: DateTime2): boolean;

	/**
	 * Behaves like DateTime2 <= DateTime2.
	 * @param dateTime
	 */
	LessThanEqualTo(dateTime: DateTime2): boolean;

	/**
	 * Behaves like DateTime2 < TimeSpan.
	 * @param dateTime
	 */
	Lt(dateTime: DateTime2): boolean;

	/**
	 * Behaves like DateTime2 <= DateTime2.
	 * @param dateTime
	 */
	Le(dateTime: DateTime2): boolean;

	/**
	 * Behaves like DateTime2 > DateTime2.
	 * @param dateTime
	 */
	GreaterThan(dateTime: DateTime2): boolean;

	/**
	 * Behaves like DateTime2 >= DateTime2.
	 * @param dateTime
	 */
	GreaterThanEqualTo(dateTime: DateTime2): boolean;

	/**
	 * Behaves like DateTime2 > TimeSpan.
	 * @param dateTime
	 */
	Gt(dateTime: DateTime2): boolean;

	/**
	 * Behaves like DateTime2 >= DateTime2.
	 * @param dateTime
	 */
	Ge(dateTime: DateTime2): boolean;

	AddDays(days: number): DateTime2;
	AddHours(hours: number): DateTime2;
	AddMilliseconds(milliseconds: number): DateTime2;
	AddMinutes(minutes: number): DateTime2;
	AddMonths(months: number): DateTime2;
	AddSeconds(seconds: number): DateTime2;
	AddWeeks(weeks: number): DateTime2;
	AddYears(years: number): DateTime2;

	ISO8601(separator?: string): string;
	ToIsoDate(): string;
	RFC2822(): string;
	ctime(): string;

	/**
	 * This returns the epoch time in seconds (using UTC).
	 */
	Epoch(): number;

	/**
	 * This returns the epoch time in milliseconds (using UTC).
	 */
	EpochMilliseconds(): number;
	OsDate(): Required<DateTable>;

	/**
	 * Formats the DateTime2 using the specified format string.
	 * @param format
	 * @param dateTimeFormatInfo
	 */
	Format(format: string, dateTimeFormatInfo?: DateTimeFormatInfo): string;
}

interface DateTimeConstructor {
	new (
		year: number,
		month: number,
		day: number,
		hour?: number,
		minute?: number,
		second?: number,
		millisecond?: number,
	): DateTime2;

	Is(this: void, value: unknown): value is DateTime2;

	FromEpoch(this: void, timestamp: number): DateTime2;
	FromISO8601(this: void, format: string): DateTime2;
	FromIsoDate(this: void, isoDate: string): DateTime2;
	FromMillisecondsEpoch(this: void, timestamp: number): DateTime2;
	FromOsDate(this: void, dateTable: Required<DateTable>): DateTime2;
	MillisecondsNow(this: void): DateTime2;
	Now(this: void): DateTime2;
	Today(this: void): DateTime2;
	UtcMillisecondsNow(this: void): DateTime2;
	UtcNow(this: void): DateTime2;

	DaysInMonth(this: void, year: number, month: number): number;
	IsLeapYear(this: void, year: number): boolean;
}

interface TimeSpanFormatInfo {
	TimeSeparator: string;
	MillisecondSeparator: string;
	DayHourMinuteSecondPattern: string;
	HourMinuteSecondPattern: string;
	HourMinuteSecondMillisecondPattern: string;
	MinuteSecondPattern: string;
	MinuteSecondMillisecondPattern: string;
	SecondMillisecondPattern: string;
	AbbreviatedDayHourMinuteSecondPattern: string;
	AbbreviatedHourMinuteSecondPattern: string;
	AbbreviatedHourMinuteSecondMillisecondPattern: string;
	AbbreviatedMinuteSecondPattern: string;
	AbbreviatedMinuteSecondMillisecondPattern: string;
	AbbreviatedSecondMillisecondPattern: string;
	FullDayHourMinuteSecondPattern: string;
	FullHourMinuteSecondPattern: string;
	FullHourMinuteSecondMillisecondPattern: string;
	FullMinuteSecondPattern: string;
	FullMinuteSecondMillisecondPattern: string;
	FullSecondMillisecondPattern: string;

	ReadOnly: boolean;

	Clone(): TimeSpanFormatInfo;
}

interface TimeSpanFormatInfoConstructor {
	new (parameters: Partial<Omit<TimeSpanFormatInfo, "Clone">>): TimeSpanFormatInfo;
	Preset: {
		da: TimeSpanFormatInfo;
		de: TimeSpanFormatInfo;
		en: TimeSpanFormatInfo;
		ja: TimeSpanFormatInfo;
	};
}

interface TimeSpan {
	TotalDays: number;
	TotalHours: number;
	TotalMinutes: number;
	TotalSeconds: number;
	TotalMilliseconds: number;
	Days: number;
	Hours: number;
	Minutes: number;
	Seconds: number;
	Milliseconds: number;

	Add(timeSpan: TimeSpan): TimeSpan;
	Sub(timeSpan: TimeSpan): TimeSpan;
	Mul(value: number): TimeSpan;
	Div(value: number): TimeSpan;
	Unm(): TimeSpan;

	/**
	 * Behaves like TimeSpan < TimeSpan.
	 * @param timeSpan
	 */
	LessThan(timeSpan: TimeSpan): boolean;

	/**
	 * Behaves like TimeSpan <= TimeSpan.
	 * @param timeSpan
	 */
	LessThanEqualTo(timeSpan: TimeSpan): boolean;

	/**
	 * Behaves like TimeSpan < TimeSpan.
	 * @param timeSpan
	 */
	Lt(timeSpan: TimeSpan): boolean;

	/**
	 * Behaves like TimeSpan <= TimeSpan.
	 * @param timeSpan
	 */
	Le(timeSpan: TimeSpan): boolean;

	/**
	 * Behaves like TimeSpan > TimeSpan.
	 * @param timeSpan
	 */
	GreaterThan(timeSpan: TimeSpan): boolean;

	/**
	 * Behaves like TimeSpan >= TimeSpan.
	 * @param timeSpan
	 */
	GreaterThanEqualTo(timeSpan: TimeSpan): boolean;

	/**
	 * Behaves like TimeSpan > TimeSpan.
	 * @param timeSpan
	 */
	Gt(timeSpan: TimeSpan): boolean;

	/**
	 * Behaves like TimeSpan >= TimeSpan.
	 * @param timeSpan
	 */
	Ge(timeSpan: TimeSpan): boolean;

	Format(format: string, timeSpanFormatInfo?: TimeSpanFormatInfo): string;
}

interface TimeSpanConstructor {
	new (milliseconds: number): TimeSpan;
	new (hours: number, minutes: number, seconds: number): TimeSpan;
	new (days: number, hours?: number, minutes?: number, seconds?: number, milliseconds?: number): TimeSpan;

	Is(this: void, value: unknown): value is TimeSpan;

	FromDays(this: void, days: number): TimeSpan;
	FromHours(this: void, hours: number): TimeSpan;
	FromMilliseconds(this: void, milliseconds: number): TimeSpan;
	FromMinutes(this: void, minutes: number): TimeSpan;
	FromSeconds(this: void, seconds: number): TimeSpan;
}

declare const DateTime2: DateTimeConstructor;
declare const DateTimeFormatInfo: DateTimeFormatInfoConstructor;

declare const TimeSpan: TimeSpanConstructor;
declare const TimeSpanFormatInfo: TimeSpanFormatInfoConstructor;

export { DateTime2, DateTime2 as DateTime, DateTimeFormatInfo, TimeSpan, TimeSpanFormatInfo };
