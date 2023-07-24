--!optimize 2
local p = {}

local function divmod(a, b)
	return math.floor(a / b), a % b
end

p.DAYS_IN_MONTH = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
p.DAYS_BEFORE_MONTH = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334}

p.MINYEAR = 1
p.MAXYEAR = 99999
p.MAXORDINAL = 4

function p.is_leap(year: number)
	return year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)
end

function p.days_before_year(year)
	year = year - 1
	return year * 365 + math.floor(year / 4) - math.floor(year / 100) + math.floor(year / 400)
end

function p.days_in_month(year: number, month: number)
	return p.DAYS_IN_MONTH[month] + ((p.is_leap(year) and month == 2) and 1 or 0)
end

function p.days_before_month(year, month)
	return p.DAYS_BEFORE_MONTH[month] + ((p.is_leap(year) and month > 2) and 1 or 0)
end

function p.ymd2ord(year, month, day)
	return p.days_before_year(year) + p.days_before_month(year, month) + day
end

p.DI400Y = p.days_before_year(401)
p.DI100Y = p.days_before_year(101)
p.DI4Y = p.days_before_year(5)

function p.ord2ymd(n)
	n = n - 1
	local n400, n = divmod(n, p.DI400Y)
	local n100, n = divmod(n, p.DI100Y)
	local n4, n = divmod(n, p.DI4Y)
	local n1, n = divmod(n, 365)

	local year = n400 * 400 + 1 + n100 * 100 + n4 * 4 + n1
	if n1 == 4 or n100 == 4 then
		return year - 1, 12, 31
	end

	local isleap = n1 == 3 and (n4 ~= 24 or n100 == 3)
	local month = bit32.rshift(n + 50, 5)
	local preceding = p.DAYS_BEFORE_MONTH[month] + ((isleap and month > 2) and 1 or 0)
	if preceding > n then
		month = month - 1
		preceding = preceding - (p.DAYS_IN_MONTH[month] + ((isleap and month == 2) and 1 or 0))
	end

	n = n - preceding

	return year, month, n + 1
end

p.MONTHNAMES = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
p.DAYNAMES = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"}
p.METATABLE = "The metatable is locked"
p.READONLY = function(self, index, value)
	return error(index .. " cannot be assigned to")
end

function p.to_raw(y, m, d, h, n, s, ms)
	if not (m or d or h or n or s or ms) and type(y) == "table" then
		return rawget(y, "_raw")
	elseif not (s or ms) then
		ms = n
		s = h
		n = d
		h = m
		d = y
		y, m = 1, 1
	end

	return (p.ymd2ord(y, m, d) * 86400_000) + (h * 3600_000) + (n * 60_000) + (s * 1_000) + ms
end

function p.from_raw(r)
	return math.floor(r / 86400_000),
		math.floor(r / 3600_000) % 24,
		math.floor(r / 60_000) % 60,
		math.floor(r / 1_000) % 60,
		r % 1_000
end

return p
