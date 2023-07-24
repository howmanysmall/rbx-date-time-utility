--!optimize 2
local dtfi = {}
local tsfi = {}
local dtfi_mt = {}
local tsfi_mt = {}

dtfi.EnumDayOfWeek = {Monday = 1, Tuesday = 2, Wednesday = 3, Thursday = 4, Friday = 5, Saturday = 6, Sunday = 7}

function dtfi_mt.__index(self, index)
	if rawget(self, index) then
		return rawget(self, index)
	elseif dtfi[index] and index ~= "new" then
		return dtfi[index]
	else
		error(index .. " is not a valid member of DateTimeFormatInfo")
	end
end

function dtfi_mt.__newindex(self, index)
	if self.ReadOnly or not self[index] or index == "ReadOnly" then
		error(index .. " cannot be assigned to")
	end
end

function dtfi.new(arg)
	arg = arg or {}
	local self = {
		StandaloneMonthNames = arg.StandaloneMonthNames or {
			"M01";
			"M02";
			"M03";
			"M04";
			"M05";
			"M06";
			"M07";
			"M08";
			"M09";
			"M10";
			"M11";
			"M12";
		};

		StandaloneDayNames = arg.StandaloneDayNames or {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
		MonthNames = arg.MonthNames or {
			"M01";
			"M02";
			"M03";
			"M04";
			"M05";
			"M06";
			"M07";
			"M08";
			"M09";
			"M10";
			"M11";
			"M12";
		};

		DayNames = arg.DayNames or {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
		AbbreviatedStandaloneMonthNames = arg.AbbreviatedStandaloneMonthNames or {
			"M01";
			"M02";
			"M03";
			"M04";
			"M05";
			"M06";
			"M07";
			"M08";
			"M09";
			"M10";
			"M11";
			"M12";
		};

		AbbreviatedStandaloneDayNames = arg.AbbreviatedStandaloneDayNames or {
			"Mon";
			"Tue";
			"Wed";
			"Thu";
			"Fri";
			"Sat";
			"Sun";
		};

		AbbreviatedMonthNames = arg.AbbreviatedMonthNames or {
			"M01";
			"M02";
			"M03";
			"M04";
			"M05";
			"M06";
			"M07";
			"M08";
			"M09";
			"M10";
			"M11";
			"M12";
		};

		AbbreviatedDayNames = arg.AbbreviatedDayNames or {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};

		AMDesignator = arg.AMDesignator or "AM";
		PMDesignator = arg.PMDesignator or "PM";

		DateSeparator = arg.DateSeparator or "-";
		TimeSeparator = arg.TimeSeparator or ":";

		ShortDatePattern = arg.ShortDatePattern or "y/MM/dd";
		LongDatePattern = arg.LongDatePattern or "y MMMM d";
		ShortTimePattern = arg.ShortTimePattern or "HH:mm:ss";
		LongTimePattern = arg.LongTimePattern or "HH:mm";
		FullDateTimePattern = arg.FullDateTimePattern or "y MMMM d HH:mm:ss";
		MonthDayPattern = arg.MonthDayPattern or "MMMM d";
		YearMonthPattern = arg.YearMonthPattern or "y MMMM";

		FirstDayOfWeek = dtfi.EnumDayOfWeek.Monday;

		ReadOnly = arg.ReadOnly or false;
	}

	return setmetatable(self, dtfi_mt)
end

function dtfi:Clone()
	local cloned = {}
	for k, v in self do
		if k ~= "ReadOnly" then
			cloned[k] = v
		end
	end

	return dtfi.new(cloned)
end

dtfi.Preset = {
	da = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"januar";
			"februar";
			"marts";
			"april";
			"maj";
			"juni";
			"juli";
			"august";
			"september";
			"oktober";
			"november";
			"december";
		};

		StandaloneDayNames = {"mandag", "tirsdag", "onsdag", "torsdag", "fredag", "lørdag", "søndag"};
		MonthNames = {
			"januar";
			"februar";
			"marts";
			"april";
			"maj";
			"juni";
			"juli";
			"august";
			"september";
			"oktober";
			"november";
			"december";
		};

		DayNames = {"mandag", "tirsdag", "onsdag", "torsdag", "fredag", "lørdag", "søndag"};
		AbbreviatedStandaloneMonthNames = {
			"jan.";
			"feb.";
			"mar.";
			"apr.";
			"maj";
			"jun.";
			"jul.";
			"aug.";
			"sep.";
			"okt.";
			"nov.";
			"dec.";
		};

		AbbreviatedStandaloneDayNames = {"man", "tir", "ons", "tor", "fre", "lør", "søn"};
		AbbreviatedMonthNames = {
			"jan.";
			"feb.";
			"mar.";
			"apr.";
			"maj";
			"jun.";
			"jul.";
			"aug.";
			"sep.";
			"okt.";
			"nov.";
			"dec.";
		};

		AbbreviatedDayNames = {"man", "tir", "ons", "tor", "fre", "lør", "søn"};

		TimeSeparator = ".";

		ShortDatePattern = "dd/MM/y";
		LongDatePattern = "d. MMMM y";
		ShortTimePattern = "HH:mm:ss";
		LongTimePattern = "HH:mm";
		FullDateTimePattern = "d. MMMM y HH:mm:ss";
		MonthDayPattern = "d. MMMM";
		YearMonthPattern = "MMMM y";
	});

	de = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"Januar";
			"Februar";
			"März";
			"April";
			"Mai";
			"Juni";
			"Juli";
			"August";
			"September";
			"Oktober";
			"November";
			"Dezember";
		};

		StandaloneDayNames = {"Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"};
		MonthNames = {
			"Januar";
			"Februar";
			"März";
			"April";
			"Mai";
			"Juni";
			"Juli";
			"August";
			"September";
			"Oktober";
			"November";
			"Dezember";
		};

		DayNames = {"Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"};
		AbbreviatedStandaloneMonthNames = {
			"Jan";
			"Feb";
			"Mär";
			"Apr";
			"Mai";
			"Jun";
			"Jul";
			"Aug";
			"Sep";
			"Okt";
			"Nov";
			"Dez";
		};

		AbbreviatedStandaloneDayNames = {"Mo.", "Di.", "Mi.", "Do.", "Fr.", "Sa.", "So."};
		AbbreviatedMonthNames = {
			"Jan";
			"Feb";
			"Mär";
			"Apr";
			"Mai";
			"Jun";
			"Jul";
			"Aug";
			"Sep";
			"Okt";
			"Nov";
			"Dez";
		};

		AbbreviatedDayNames = {"Mo.", "Di.", "Mi.", "Do.", "Fr.", "Sa.", "So."};

		DateSeparator = ".";

		ShortDatePattern = "dd/MM/y";
		LongDatePattern = "d MMMM y";
		ShortTimePattern = "HH:mm:ss";
		LongTimePattern = "HH:mm";
		FullDateTimePattern = "d MMMM y HH:mm:ss";
		MonthDayPattern = "d MMMM";
		YearMonthPattern = "MMMM y";
	});

	en = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"January";
			"February";
			"March";
			"April";
			"May";
			"June";
			"July";
			"August";
			"September";
			"October";
			"November";
			"December";
		};

		StandaloneDayNames = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
		MonthNames = {
			"January";
			"February";
			"March";
			"April";
			"May";
			"June";
			"July";
			"August";
			"September";
			"October";
			"November";
			"December";
		};

		DayNames = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
		AbbreviatedStandaloneMonthNames = {
			"Jan";
			"Feb";
			"Mar";
			"Apr";
			"May";
			"Jun";
			"Jul";
			"Aug";
			"Sep";
			"Oct";
			"Nov";
			"Dec";
		};

		AbbreviatedMonthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

		DateSeparator = "/";

		ShortDatePattern = "M/d/y";
		LongDatePattern = "MMMM d, y";
		ShortTimePattern = "h:mm:ss a";
		LongTimePattern = "h:mm a";
		FullDateTimePattern = "MMMM d, y h:mm:ss a";
		MonthDayPattern = "MMMM d";
		YearMonthPattern = "MMMM y";

		FirstDayOfWeek = dtfi.EnumDayOfWeek.Sunday;
	});

	en_001 = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"January";
			"February";
			"March";
			"April";
			"May";
			"June";
			"July";
			"August";
			"September";
			"October";
			"November";
			"December";
		};

		StandaloneDayNames = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
		MonthNames = {
			"January";
			"February";
			"March";
			"April";
			"May";
			"June";
			"July";
			"August";
			"September";
			"October";
			"November";
			"December";
		};

		DayNames = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
		AbbreviatedStandaloneMonthNames = {
			"Jan";
			"Feb";
			"Mar";
			"Apr";
			"May";
			"Jun";
			"Jul";
			"Aug";
			"Sep";
			"Oct";
			"Nov";
			"Dec";
		};

		AbbreviatedMonthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

		DateSeparator = "/";

		ShortDatePattern = "dd/MM/y";
		LongDatePattern = "d MMMM y";
		ShortTimePattern = "HH:mm:ss";
		LongTimePattern = "HH:mm";
		FullDateTimePattern = "d MMMM y HH:mm:ss";
		MonthDayPattern = "d MMMM";
		YearMonthPattern = "MMMM y";
	});

	es = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"enero";
			"febrero";
			"marzo";
			"abril";
			"mayo";
			"junio";
			"julio";
			"agosto";
			"septiembre";
			"octubre";
			"noviembre";
			"diciembre";
		};

		StandaloneDayNames = {"lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"};
		MonthNames = {
			"enero";
			"febrero";
			"marzo";
			"abril";
			"mayo";
			"junio";
			"julio";
			"agosto";
			"septiembre";
			"octubre";
			"noviembre";
			"diciembre";
		};

		DayNames = {"lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"};
		AbbreviatedStandaloneMonthNames = {
			"ene.";
			"feb.";
			"mar.";
			"abr.";
			"may.";
			"jun.";
			"jul.";
			"ago.";
			"sept.";
			"oct.";
			"nov.";
			"dic.";
		};

		AbbreviatedStandaloneDayNames = {"lun.", "mar.", "mié.", "jue.", "vie.", "sáb.", "dom."};
		AbbreviatedMonthNames = {
			"ene.";
			"feb.";
			"mar.";
			"abr.";
			"may.";
			"jun.";
			"jul.";
			"ago.";
			"sept.";
			"oct.";
			"nov.";
			"dic.";
		};

		AbbreviatedDayNames = {"lun.", "mar.", "mié.", "jue.", "vie.", "sáb.", "dom."};

		AMDesignator = "a. m.";
		PMDesignator = "p. m.";

		DateSeparator = "/";

		ShortDatePattern = "dd/MM/y";
		LongDatePattern = "d 'de' MMMM 'de' y";
		ShortTimePattern = "HH:mm:ss";
		LongTimePattern = "HH:mm";
		FullDateTimePattern = "d 'de' MMMM 'de' y HH:mm:ss";
		MonthDayPattern = "d 'de' MMMM";
		YearMonthPattern = "MMMM 'de' y";
	});

	es_419 = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"enero";
			"febrero";
			"marzo";
			"abril";
			"mayo";
			"junio";
			"julio";
			"agosto";
			"septiembre";
			"octubre";
			"noviembre";
			"diciembre";
		};

		StandaloneDayNames = {"lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"};
		MonthNames = {
			"enero";
			"febrero";
			"marzo";
			"abril";
			"mayo";
			"junio";
			"julio";
			"agosto";
			"septiembre";
			"octubre";
			"noviembre";
			"diciembre";
		};

		DayNames = {"lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"};
		AbbreviatedStandaloneMonthNames = {
			"ene.";
			"feb.";
			"mar.";
			"abr.";
			"may.";
			"jun.";
			"jul.";
			"ago.";
			"sept.";
			"oct.";
			"nov.";
			"dic.";
		};

		AbbreviatedStandaloneDayNames = {"lun.", "mar.", "mié.", "jue.", "vie.", "sáb.", "dom."};
		AbbreviatedMonthNames = {
			"ene.";
			"feb.";
			"mar.";
			"abr.";
			"may.";
			"jun.";
			"jul.";
			"ago.";
			"sept.";
			"oct.";
			"nov.";
			"dic.";
		};

		AbbreviatedDayNames = {"lun.", "mar.", "mié.", "jue.", "vie.", "sáb.", "dom."};

		AMDesignator = "a. m.";
		PMDesignator = "p. m.";

		DateSeparator = "/";

		ShortDatePattern = "dd/MM/y";
		LongDatePattern = "d 'de' MMMM 'de' y";
		ShortTimePattern = "hh:mm:ss tt";
		LongTimePattern = "hh:mm tt";
		FullDateTimePattern = "d 'de' MMMM 'de' y hh:mm:ss tt";
		MonthDayPattern = "d 'de' MMMM";
		YearMonthPattern = "MMMM 'de' y";

		FirstDayOfWeek = dtfi.EnumDayOfWeek.Sunday;
	});

	fr = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"janvier";
			"février";
			"mars";
			"avril";
			"mai";
			"juin";
			"juillet";
			"août";
			"septembre";
			"octobre";
			"novembre";
			"décembre";
		};

		StandaloneDayNames = {"lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"};
		MonthNames = {
			"janvier";
			"février";
			"mars";
			"avril";
			"mai";
			"juin";
			"juillet";
			"août";
			"septembre";
			"octobre";
			"novembre";
			"décembre";
		};

		DayNames = {"lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"};
		AbbreviatedStandaloneMonthNames = {
			"janv.";
			"févr.";
			"mars";
			"avr.";
			"mai";
			"juin";
			"juil.";
			"août";
			"sept.";
			"oct.";
			"nov.";
			"déc.";
		};

		AbbreviatedStandaloneDayNames = {"lun.", "mar.", "mer.", "jeu.", "ven.", "sam.", "dim."};
		AbbreviatedMonthNames = {
			"janv.";
			"févr.";
			"mars";
			"avr.";
			"mai";
			"juin";
			"juil.";
			"août";
			"sept.";
			"oct.";
			"nov.";
			"déc.";
		};

		AbbreviatedDayNames = {"lun.", "mar.", "mer.", "jeu.", "ven.", "sam.", "dim."};

		DateSeparator = "/";

		ShortDatePattern = "dd/MM/y";
		LongDatePattern = "d MMMM y";
		ShortTimePattern = "HH:mm:ss";
		LongTimePattern = "HH:mm";
		FullDateTimePattern = "d MMMM y HH:mm:ss";
		MonthDayPattern = "d MMMM";
		YearMonthPattern = "MMMM y";
	});

	ja = dtfi.new({
		ReadOnly = true;
		StandaloneMonthNames = {
			"1月";
			"2月";
			"3月";
			"4月";
			"5月";
			"6月";
			"7月";
			"8月";
			"9月";
			"10月";
			"11月";
			"12月";
		};

		StandaloneDayNames = {
			"月曜日";
			"火曜日";
			"水曜日";
			"木曜日";
			"金曜日";
			"土曜日";
			"日曜日";
		};

		MonthNames = {
			"1月";
			"2月";
			"3月";
			"4月";
			"5月";
			"6月";
			"7月";
			"8月";
			"9月";
			"10月";
			"11月";
			"12月";
		};

		DayNames = {"月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"};
		AbbreviatedStandaloneMonthNames = {
			"1月";
			"2月";
			"3月";
			"4月";
			"5月";
			"6月";
			"7月";
			"8月";
			"9月";
			"10月";
			"11月";
			"12月";
		};

		AbbreviatedStandaloneDayNames = {"月", "火", "水", "木", "金", "土", "日"};
		AbbreviatedMonthNames = {
			"1月";
			"2月";
			"3月";
			"4月";
			"5月";
			"6月";
			"7月";
			"8月";
			"9月";
			"10月";
			"11月";
			"12月";
		};

		AbbreviatedDayNames = {"月", "火", "水", "木", "金", "土", "日"};

		DateSeparator = "/";

		ShortDatePattern = "y/MM/dd";
		LongDatePattern = "y年M月d日";
		ShortTimePattern = "HH:mm:ss";
		LongTimePattern = "HH:mm";
		FullDateTimePattern = "y年M月d日 HH:mm:ss";
		MonthDayPattern = "M月d日";
		YearMonthPattern = "y年M月";

		FirstDayOfWeek = dtfi.EnumDayOfWeek.Sunday;
	});
}

--

function tsfi_mt.__index(self, index)
	if rawget(self, index) then
		return rawget(self, index)
	elseif dtfi[index] and index ~= "new" then
		return dtfi[index]
	else
		error(index .. " is not a valid member of TimeSpanInfo")
	end
end

function tsfi_mt.__newindex(self, index)
	if self.ReadOnly or not self[index] or index == "ReadOnly" then
		error(index .. " cannot be assigned to")
	end
end

function tsfi.new(arg)
	arg = arg or {}

	return setmetatable({
		TimeSeparator = arg.TimeSeparator or ":";
		MillisecondSeparator = arg.MillisecondSeparator or ",";

		DayHourMinuteSecondPattern = arg.DayHourMinuteSecondPattern or "d:hh:mm:ss";
		HourMinuteSecondPattern = arg.HourMinuteSecondPattern or "h:mm:ss";
		HourMinuteSecondMillisecondPattern = arg.HourMinuteSecondMillisecondPattern or "h:mm:ss,fff";
		MinuteSecondPattern = arg.MinuteSecondPattern or "m:ss";
		MinuteSecondMillisecondPattern = arg.MinuteSecondMillisecondPattern or "m:ss,fff";
		SecondMillisecondPattern = arg.SecondMillisecondPattern or "ss,fff";

		AbbreviatedDayHourMinuteSecondPattern = arg.AbbreviatedDayHourMinuteSecondPattern or "d:hh:mm:ss";
		AbbreviatedHourMinuteSecondPattern = arg.AbbreviatedHourMinuteSecondPattern or "h:mm:ss";
		AbbreviatedHourMinuteSecondMillisecondPattern = arg.AbbreviatedHourMinuteSecondMillisecondPattern
			or "h:mm:ss,fff";
		AbbreviatedMinuteSecondPattern = arg.AbbreviatedMinuteSecondPattern or "m:ss";
		AbbreviatedMinuteSecondMillisecondPattern = arg.AbbreviatedMinuteSecondMillisecondPattern or "m:ss,fff";
		AbbreviatedSecondMillisecondPattern = arg.AbbreviatedSecondMillisecondPattern or "ss,fff";

		FullDayHourMinuteSecondPattern = arg.FullDayHourMinuteSecondPattern or "d:hh:mm:ss";
		FullHourMinuteSecondPattern = arg.FullHourMinuteSecondPattern or "h:mm:ss";
		FullHourMinuteSecondMillisecondPattern = arg.FullHourMinuteSecondMillisecondPattern or "h:mm:ss,fff";
		FullMinuteSecondPattern = arg.FullMinuteSecondPattern or "m:ss";
		FullMinuteSecondMillisecondPattern = arg.FullMinuteSecondMillisecondPattern or "m:ss,fff";
		FullSecondMillisecondPattern = arg.FullSecondMillisecondPattern or "ss,fff";

		ReadOnly = arg.ReadOnly or false;
	}, tsfi_mt)
end

function tsfi:Clone()
	local cloned = {}
	for k, v in self do
		if k ~= "ReadOnly" then
			cloned[k] = v
		end
	end

	return dtfi.new(cloned)
end

tsfi.Preset = {
	da = tsfi.new({
		ReadOnly = true;

		TimeSeparator = ".";

		AbbreviatedDayHourMinuteSecondPattern = "d'd' h't' m'm' s's'";
		AbbreviatedHourMinuteSecondPattern = "h't' m'm' s's'";
		AbbreviatedHourMinuteSecondMillisecondPattern = "h't' m'm' s's' ffff'ms'";
		AbbreviatedMinuteSecondPattern = "m'm' s's'";
		AbbreviatedMinuteSecondMillisecondPattern = "m'm' s's' ffff'ms'";
		AbbreviatedSecondMillisecondPattern = "s's' ffff'ms'";

		FullDayHourMinuteSecondPattern = "d 'dag(e),' h 'time(r),' m 'minut(ter),' s 'sekund(er)'";
		FullHourMinuteSecondPattern = "h 'time(r),' m 'minut(ter),' s 'sekund(er)'";
		FullHourMinuteSecondMillisecondPattern = "h 'time(r),' m 'minut(ter),' s 'sekund(er),' ffff 'millisekund(er)'";
		FullMinuteSecondPattern = "m 'minut(ter),' s 'sekund(er)'";
		FullMinuteSecondMillisecondPattern = "m 'minut(ter),' s 'sekund(er),' ffff 'millisekund(er)'";
		FullSecondMillisecondPattern = "s 'sekund(er),' ffff 'millisekund(er)'";
	});

	de = tsfi.new({
		ReadOnly = true;

		AbbreviatedDayHourMinuteSecondPattern = "d't' h'h' m'm' s's'";
		AbbreviatedHourMinuteSecondPattern = "h'h' m'm' s's'";
		AbbreviatedHourMinuteSecondMillisecondPattern = "h'h' m'm' s's' ffff'ms'";
		AbbreviatedMinuteSecondPattern = "m'm' s's'";
		AbbreviatedMinuteSecondMillisecondPattern = "m'm' s's' ffff'ms'";
		AbbreviatedSecondMillisecondPattern = "s's' ffff'ms'";

		FullDayHourMinuteSecondPattern = "d 'tag(e),' h 'stunde(n),' m 'minute(s),' s 'sekunde(n)'";
		FullHourMinuteSecondPattern = "h 'stunde(n),' m 'minute(n),' s 'sekunde(n)'";
		FullHourMinuteSecondMillisecondPattern = "h 'stunde(n),' m 'minute(n),' s 'sekunde(n),' ffff 'millisekunde(n)'";
		FullMinuteSecondPattern = "m 'minute(s),' s 'sekunde(n)'";
		FullMinuteSecondMillisecondPattern = "m 'minute(n),' s 'sekunde(n),' ffff 'millisekunde(n)'";
		FullSecondMillisecondPattern = "s 'sekunde(n),' ffff 'millisekunde(n)'";
	});

	en = tsfi.new({
		ReadOnly = true;

		MillisecondSeparator = ".";

		AbbreviatedDayHourMinuteSecondPattern = "d'd' h'h' m'm' s's'";
		AbbreviatedHourMinuteSecondPattern = "h'h' m'm' s's'";
		AbbreviatedHourMinuteSecondMillisecondPattern = "h'h' m'm' s's' ffff'ms'";
		AbbreviatedMinuteSecondPattern = "m'm' s's'";
		AbbreviatedMinuteSecondMillisecondPattern = "m'm' s's' ffff'ms'";
		AbbreviatedSecondMillisecondPattern = "s's' ffff'ms'";

		FullDayHourMinuteSecondPattern = "d 'day(s),' h 'hour(s),' m 'minute(s),' s 'second(s)'";
		FullHourMinuteSecondPattern = "h 'hour(s),' m 'minute(s),' s 'second(s)'";
		FullHourMinuteSecondMillisecondPattern = "h 'hour(s),' m 'minute(s),' s 'second(s),' ffff 'millisecond(s)'";
		FullMinuteSecondPattern = "m 'minute(s),' s 'second(s)'";
		FullMinuteSecondMillisecondPattern = "m 'minute(s),' s 'second(s),' ffff 'millisecond(s)'";
		FullSecondMillisecondPattern = "s 'second(s),' ffff 'millisecond(s)'";
	});

	ja = tsfi.new({
		ReadOnly = true;

		MillisecondSeparator = ".";

		FullDayHourMinuteSecondPattern = "d'日,'h'時間,'m'分,'s'秒'";
		FullHourMinuteSecondPattern = "h'時間,'m'分,'s'秒'";
		FullHourMinuteSecondMillisecondPattern = "h'時間,'m'分,'s'秒,'ffff'ミリ秒'";
		FullMinuteSecondPattern = "m'分,'s'秒'";
		FullMinuteSecondMillisecondPattern = "m'分,'s'秒,'ffff'ミリ秒'";
		FullSecondMillisecondPattern = "s'秒,'ffff'ミリ秒'";
	});
}

--
return table.freeze({
	dt = dtfi;
	ts = tsfi;
})
