--!optimize 2
local ts = require(script.Parent.TimeSpan)
local pf = require(script.Parent.PrivateFunction)
local Types = require(script.Parent.Types)

local dt = {}
local mt = {}

local JS_WEEKDAY = {
	[1] = 1;
	[2] = 2;
	[3] = 3;
	[4] = 4;
	[5] = 5;
	[6] = 6;
	[7] = 0;
}

function mt.__index(self, index)
	local _raw = rawget(self, "_raw")
	local td, h, n, s, ms = pf.from_raw(_raw)
	local y, m, d = pf.ord2ymd(td)
	local weekday = (td - 1) % 7 + 1
	local prop = {
		Year = y;
		Month = m;
		Day = d;
		Hour = h;
		Minute = n;
		Second = s;
		Millisecond = ms;
		Weekday = weekday;
		JsWeekday = JS_WEEKDAY[weekday];
		Ordinal = pf.days_before_month(y, m) + d;
		TimeOfDay = ts.new(h, m, s);
	}

	if prop[index] then
		return prop[index]
	elseif dt[index] and index ~= "new" then
		return dt[index]
	else
		error(index .. " is not a valid member of DateTime")
	end
end

function mt.__add(a, b)
	local r = pf.to_raw(a) + pf.to_raw(b)
	local d, h, n, s = pf.from_raw(r)
	local y, m, d2 = pf.ord2ymd(d)
	return dt.new(y, m, d2, h, n, s)
end

local function ReturnTotalSeconds(Value)
	return Value.TotalSeconds
end

function mt.__sub(a, b)
	local r = pf.to_raw(a) - pf.to_raw(b)
	if pcall(ReturnTotalSeconds, b) then
		local d, h, n, s = pf.from_raw(r)
		local y, m, d2 = pf.ord2ymd(d)
		return dt.new(y, m, d2, h, n, s)
	else
		return ts.new(r)
	end
end

function mt.__lt(a, b)
	return pf.to_raw(a) < pf.to_raw(b)
end

function mt.__le(a, b)
	return pf.to_raw(a) <= pf.to_raw(b)
end

function mt.__eq(a, b)
	return pf.to_raw(a) == pf.to_raw(b)
end

function mt.__tostring(self)
	return self:ISO8601()
end

mt.__newindex = pf.READONLY
-- mt.__metatable = pf.METATABLE

function dt.new(
	year: number,
	month: number,
	day: number,
	hour: number?,
	minute: number?,
	second: number?,
	millisecond: number?
): Types.DateTime2
	hour, minute, second, millisecond = hour or 0, minute or 0, second or 0, millisecond or 0
	if
		year < pf.MINYEAR
		or year > pf.MAXYEAR
		or month < 1
		or month > 12
		or day < 1
		or day > pf.days_in_month(year, month)
	then
		error("year, month, and day parameters describe an un-representable DateTime.")
	elseif hour < 0 or hour > 59 or minute < 0 or minute > 59 or second < 0 or second > 59 then
		error("hour, minute, and second parameters describe an un-representable DateTime.")
	elseif millisecond > 999 or millisecond < 0 then
		error("millisecond parameter describe an un-representable DateTime.")
	end

	return (
		setmetatable({_raw = pf.to_raw(year, month, day, hour, minute, second, millisecond)}, mt) :: any
	) :: Types.DateTime2
end

local UNIX_EPOCH = dt.new(1970, 1, 1)

function dt.Is(value)
	return type(value) == "table" and getmetatable(value) == mt
end

function dt.FromEpoch(timestamp: number): Types.DateTime2
	return UNIX_EPOCH + ts.new(0, 0, timestamp)
end

function dt.FromMillisecondsEpoch(timestamp: number): Types.DateTime2
	return UNIX_EPOCH + ts.new(timestamp)
end

function dt.FromISO8601(format: string): Types.DateTime2
	local year, month, day, hour, minute, second, millisecond =
		string.match(format, "(%d%d%d%d)-(%d%d)-(%d%d)T?(%d%d):(%d%d):(%d%d)Z?")

	return dt.new(year, month, day, hour, minute, second, millisecond)
end

function dt.FromIsoDate(isoDate: string): Types.DateTime2
	local year, month, day, hour, minute, second, millisecond =
		string.match(isoDate, "(%d%d%d%d)-(%d%d)-(%d%d)T?(%d%d):(%d%d):(%d%d)Z?")

	return dt.new(year, month, day, hour, minute, second, millisecond)
end

function dt.fromIsoDate(isoDate: string): Types.DateTime2
	local year, month, day, hour, minute, second, millisecond =
		string.match(isoDate, "(%d%d%d%d)-(%d%d)-(%d%d)T?(%d%d):(%d%d):(%d%d)Z?")

	return dt.new(year, month, day, hour, minute, second, millisecond)
end

function dt.FromOsDate(osdate): Types.DateTime2
	return dt.new(osdate.year, osdate.month, osdate.day, osdate.hour, osdate.min, osdate.sec)
end

function dt.Now(): Types.DateTime2
	return dt.FromEpoch(math.floor(tick()))
end

function dt.MillisecondsNow()
	return dt.FromMillisecondsEpoch(math.floor(tick() * 1000))
end

function dt.UtcNow(): Types.DateTime2
	return dt.FromEpoch(os.time())
end

function dt.UtcMillisecondsNow(): Types.DateTime2
	return dt.FromMillisecondsEpoch(os.time() * 1000 + math.floor(tick() * 1000 % 1000))
end

function dt.Today(): Types.DateTime2
	local n = dt.Now()
	return dt.new(n.Year, n.Month, n.Day)
end

dt.DaysInMonth = pf.days_in_month
dt.IsLeapYear = pf.is_leap

function dt:Add(b)
	return self + b
end

function dt:Sub(b)
	return self - b
end

function dt:Lt(b)
	return self < b
end

function dt:Le(b)
	return self <= b
end

function dt:Gt(b)
	return self > b
end

function dt:Ge(b)
	return self >= b
end

function dt:LessThan(b)
	return self < b
end

function dt:LessThanEqualTo(b)
	return self <= b
end

function dt:GreaterThan(b)
	return self > b
end

function dt:GreaterThanEqualTo(b)
	return self >= b
end

function dt:AddMilliseconds(value: number)
	return self + ts.new(value)
end

function dt:AddSeconds(value: number)
	return self + ts.new(0, 0, value)
end

function dt:AddMinutes(value: number)
	return self + ts.new(0, value, 0)
end

function dt:AddHours(value: number)
	return self + ts.new(value, 0, 0)
end

function dt:AddDays(value: number)
	return self + ts.new(value, 0, 0, 0)
end

function dt:AddWeeks(value: number)
	return self + ts.new(value * 7, 0, 0, 0)
end

function dt:AddMonths(value: number)
	local d, m, y = self.Day, self.Month + value, self.Year
	y += math.floor(m / 12)
	m = (m - 1) % 12 + 1
	d = math.min(pf.days_in_month(y, m), d)
	return dt.new(y, m, d, self.Hour, self.Minute, self.Second)
end

function dt:AddYears(value: number)
	local d, m, y = self.Day, self.Month, self.Year
	y += value
	d = math.min(pf.days_in_month(y, m), d)
	return dt.new(y, m, d, self.Hour, self.Minute, self.Second)
end

function dt:ISO8601(sep: string?)
	return string.format(
		"%04d-%02d-%02d%*%02d:%02d:%02d%*",
		self.Year,
		self.Month,
		self.Day,
		sep or " ",
		self.Hour,
		self.Minute,
		self.Second,
		self.Millisecond == 0 and "" or string.format(".%06d", self.Millisecond)
	)
end

function dt:ToIsoDate()
	return string.format(
		"%04d-%02d-%02d%*%02d:%02d:%02d%*",
		self.Year,
		self.Month,
		self.Day,
		"T",
		self.Hour,
		self.Minute,
		self.Second,
		self.Millisecond == 0 and "" or string.format(".%06d", self.Millisecond)
	)
end

function dt:RFC2822()
	return string.format(
		"%*, %02d %* %04d, %02d:%02d:%02d +0000",
		pf.DAYNAMES[self.Weekday],
		self.Day,
		pf.MONTHNAMES[self.Month],
		self.Year,
		self.Hour,
		self.Minute,
		self.Second
	)
end

function dt:ctime()
	return string.format(
		"%* %* %2d %02d:%02d:%02d %04d",
		pf.DAYNAMES[self.Weekday],
		pf.MONTHNAMES[self.Month],
		self.Day,
		self.Hour,
		self.Minute,
		self.Second,
		self.Year
	)
end

function dt:Epoch(): number
	return (self - UNIX_EPOCH).TotalSeconds
end

function dt:EpochMilliseconds(): number
	return (self - UNIX_EPOCH).TotalMilliseconds
end

function dt:OsDate(): typeof(os.date("!*t"))
	return os.date("!*t", self:Epoch())
end

local _DATEPATTERN = "[yMdEahHmsf':/]"
local _specifier = {
	d = "y-MM-dd";
	D = "EEEE, d MMMM y";
	f = "EEEE, d MMMM y HH:mm";
	F = "EEEE, d MMMM y HH:mm:ss";
	g = "y-MM-dd HH:mm";
	G = "y-MM-dd HH:mm:ss";
	m = "d MMMM";
	M = "d MMMM";
	t = "HH:mm";
	T = "HH:mm:ss";
	y = "MMMM y";
	Y = "MMMM y";
}

local _names = {
	mo = {
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

	wd = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
}

function dt:Format(format: string, dtfi)
	local specifier = _specifier
	if dtfi then
		specifier = {
			d = dtfi.ShortDatePattern;
			D = dtfi.LongDatePattern;
			f = dtfi.LongDatePattern .. " " .. dtfi.ShortTimePattern;
			F = dtfi.FullDateTimePattern;
			g = dtfi.ShortDatePattern .. " " .. dtfi.ShortTimePattern;
			G = dtfi.ShortDatePattern .. " " .. dtfi.LongTimePattern;
			m = dtfi.MonthDayPattern;
			M = dtfi.MonthDayPattern;
			t = dtfi.ShortTimePattern;
			T = dtfi.ShortDatePattern;
			y = dtfi.YearMonthPattern;
			Y = dtfi.YearMonthPattern;
		}
	else
		dtfi = {}
	end

	local names = {
		mo = dtfi.MonthNames or _names.mo;
		abmo = dtfi.AbbreviatedMonthNames or pf.MONTHNAMES;
		wd = dtfi.AbbreviatedMonthNames or _names.wd;
		abwd = dtfi.AbbreviatedDayNames or pf.DAYNAMES;
		dp = {[true] = dtfi.AMDesignator or "AM", [false] = dtfi.PMDesignator or "PM"};
	}

	format = specifier[format] or format

	local year = self.Year
	local month = self.Month
	local day = self.Day
	local weekday = self.Weekday
	local hour = self.Hour
	local minute = self.Minute
	local second = self.Second
	local millisecond = self.Millisecond

	local prop = {
		y = year;
		yy = string.format("%02d", year % 100);
		yyy = string.format("%03d", year);
		yyyy = string.format("%04d", year);
		yyyyy = string.format("%05d", year);
		yyyyyy = string.format("%06d", year);
		M = month;
		MM = string.format("%02d", month);
		MMM = names.abmo[month];
		MMMM = names.mo[month];
		d = day;
		dd = string.format("%02d", day);
		E = names.abwd[weekday];
		EE = names.abwd[weekday];
		EEE = names.abwd[weekday];
		EEEE = names.wd[weekday];
		a = names.dp[hour < 12];
		aa = names.dp[hour < 12];
		h = (hour - 1) % 12 + 1;
		hh = string.format("%02d", (hour - 1) % 12 + 1);
		H = hour;
		HH = string.format("%02d", hour);
		m = minute;
		mm = string.format("%02d", minute);
		s = second;
		ss = string.format("%02d", second);
		f = millisecond % 10;
		ff = string.format("%02d", millisecond % 100);
		fff = string.format("%03d", millisecond);
	}

	local ret = {}
	local length = 0
	local i = 1
	repeat
		local c = string.sub(format, i, i)
		local ri = i + 1
		local r = ""
		if c == "'" then
			ri = (string.find(format, "'", i + 1) or #format) + 1
			r = string.sub(format, i + 1, ri - 2)
			r = r == "" and "'" or r
		elseif c == "/" then
			r = dtfi.DateSeparator or "/"
		elseif c == ":" then
			r = dtfi.TimeSeparator or ":"
		elseif string.match(c, _DATEPATTERN) then
			_, ri = string.find(format, c .. "+", i)
			r = string.sub(format, i, ri)
			r = prop[r]
			r = r or ""

			ri = (ri or #format) + 1
		else
			ri = string.find(format, _DATEPATTERN, i) or #format + 1
			r = string.sub(format, i, ri - 1)
		end

		i = ri
		length += 1
		ret[length] = r
	until c == "" or not i

	return table.concat(ret)
end

return dt
