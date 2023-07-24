--!optimize 2
local pf = require(script.Parent.PrivateFunction)
local ts = {}
local mt = {}

function mt.__index(self, index)
	local _raw = rawget(self, "_raw")
	local td, h, m, s, ms = pf.from_raw(_raw)
	local prop = {
		TotalDays = _raw / 86_400_000;
		TotalHours = _raw / 3_600_000;
		TotalMinutes = _raw / 60_000;
		TotalSeconds = _raw / 1_000;
		TotalMilliseconds = _raw;
		Days = td;
		Hours = h;
		Minutes = m;
		Seconds = s;
		Milliseconds = ms;
	}

	if prop[index] then
		return prop[index]
	elseif ts[index] and index ~= "new" then
		return ts[index]
	else
		error(index .. " is not a valid member of TimeSpan")
	end
end

function mt.__add(a, b)
	return ts.new(pf.to_raw(a) + pf.to_raw(b))
end

function mt.__sub(a, b)
	return ts.new(pf.to_raw(a) - pf.to_raw(b))
end

function mt.__mul(a, b)
	return ts.new(pf.to_raw(a) * b)
end

function mt.__div(a, b)
	return ts.new(pf.to_raw(a) / b)
end

function mt.__unm(a)
	return ts.new(pf.to_raw(a) * -1)
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
	return string.format(
		"%d,%02d:%02d:%02d%*",
		self.Days,
		self.Hours,
		self.Minutes,
		self.Seconds,
		self.Milliseconds == 0 and "" or string.format(",%02d", self.Milliseconds)
	)
end

mt.__newindex = pf.READONLY

function ts.new(days: number, hours: number?, minutes: number?, seconds: number?, millisecond: number?)
	if not (hours or minutes or seconds or millisecond) then
		millisecond = days
		days = 0
		hours = 0
		minutes = 0
		seconds = 0
	elseif not (seconds or millisecond) then
		seconds = minutes
		minutes = hours
		hours = days
		days = 0
		millisecond = 0
	elseif not millisecond then
		millisecond = 0
	end

	return setmetatable({_raw = pf.to_raw(days, hours, minutes, seconds, millisecond)}, mt)
end

function ts.Is(value)
	return type(value) == "table" and getmetatable(value) == mt
end

ts.FromMilliseconds = ts.new
function ts.FromSeconds(value: number)
	return ts.new(0, 0, value)
end

function ts.FromMinutes(value: number)
	return ts.new(0, value, 0)
end

function ts.FromHours(value: number)
	return ts.new(value, 0, 0)
end

function ts.FromDays(value: number)
	return ts.new(value, 0, 0, 0)
end

function ts:Add(b)
	return self + b
end

function ts:Sub(b)
	return self - b
end

function ts:Mul(b)
	return self * b
end

function ts:Div(b)
	return self / b
end

function ts:Unm()
	return -self
end

function ts:Lt(b)
	return self < b
end

function ts:Le(b)
	return self <= b
end

function ts:Gt(b)
	return self > b
end

function ts:Ge(b)
	return self >= b
end

function ts:LessThan(b)
	return self < b
end

function ts:LessThanEqualTo(b)
	return self <= b
end

function ts:GreaterThan(b)
	return self > b
end

function ts:GreaterThanEqualTo(b)
	return self >= b
end

local ZERO_TIMESPAN = ts.new(0)
local _TIMESPANPATTERN = "[dhmsf':,;]"
function ts:Format(format: string, tsfi)
	if tsfi then
		local specifier = {
			dhms = tsfi.DayHourMinuteSecondPattern;
			hms = tsfi.HourMinuteSecondPattern;
			hmsf = tsfi.HourMinuteSecondMillisecondPattern;
			ms = tsfi.MinuteSecondPattern;
			msf = tsfi.MinuteSecondMillisecondPattern;
			sf = tsfi.SecondMillisecondPattern;

			adhms = tsfi.AbbreviatedDayHourMinuteSecondPattern;
			ahms = tsfi.AbbreviatedHourMinuteSecondPattern;
			ahmsf = tsfi.AbbreviatedHourMinuteSecondMillisecondPattern;
			af = tsfi.AbbreviatedMinuteSecondPattern;
			amsf = tsfi.AbbreviatedMinuteSecondMillisecondPattern;
			asf = tsfi.AbbreviatedSecondMillisecondPattern;

			fdhms = tsfi.FullDayHourMinuteSecondPattern;
			fhms = tsfi.FullHourMinuteSecondPattern;
			fhmsf = tsfi.FullHourMinuteSecondMillisecondPattern;
			fms = tsfi.FullMinuteSecondPattern;
			fmsf = tsfi.FullMinuteSecondMillisecondPattern;
			fsf = tsfi.FullSecondMillisecondPattern;
		}

		format = specifier[format] or format
	else
		tsfi = {}
	end

	local is_neg = self < ZERO_TIMESPAN
	if is_neg and not string.match(string.gsub(format, "'[^']+'", ""), ";") then
		format ..= ";-" .. format
	end

	local days = self.Days
	local hours = self.Hours
	local minutes = self.Minutes
	local seconds = self.Seconds
	local milliseconds = self.Milliseconds

	local prop = {
		d = days;
		dd = string.format("%02d", days);
		ddd = string.format("%03d", days);
		dddd = string.format("%04d", days);
		ddddd = string.format("%05d", days);
		dddddd = string.format("%06d", days);
		ddddddd = string.format("%07d", days);
		dddddddd = string.format("%08d", days);
		h = hours;
		hh = string.format("%02d", hours);
		m = minutes;
		mm = string.format("%02d", minutes);
		s = seconds;
		ss = string.format("%02d", seconds);
		f = milliseconds % 10;
		ff = string.format("%02d", milliseconds % 100);
		fff = string.format("%03d", milliseconds);
		ffff = milliseconds;
	}

	local position_neg = false
	local ret = {[true] = "", [false] = ""}
	local i = 1
	repeat
		local c = string.sub(format, i, i)
		local ri = i + 1
		local r = ""
		if c == "'" then
			ri = (string.find(format, "'", i + 1) or #format) + 1
			r = string.sub(format, i + 1, ri - 2)
			r = r == "" and "'" or r
		elseif c == "%" then
			r = string.sub(format, ri, ri)
			if string.match(r, _TIMESPANPATTERN) then
				r = prop[r]
				ri = ri + 1
			else
				r = "%"
			end
		elseif c == ";" then
			position_neg = true
		elseif c == ":" then
			r = tsfi.TimeSeparator or ":"
		elseif c == "," then
			r = tsfi.MillisecondSeparator or ","
		elseif string.match(c, _TIMESPANPATTERN) then
			_, ri = string.find(format, c .. "+", i)
			r = string.sub(format, i, ri)
			r = prop[r]
			r = r or ""

			ri = (ri or #format) + 1
		else
			ri = string.find(format, _TIMESPANPATTERN, i) or #format + 1
			r = string.sub(format, i, ri - 1)
		end

		i = ri
		ret[position_neg] ..= r
	until c == "" or not i

	return ret[is_neg]
end

return ts
