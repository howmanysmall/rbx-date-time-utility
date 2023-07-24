--!optimize 2
-- semver 1.0.0
local dtfi = require(script.DateTimeFormatInfo)
local DateTime = require(script.DateTime)
local Types = require(script.Types)

export type DateTimeFormatInfo = Types.DateTimeFormatInfo
export type DateTime2 = Types.DateTime2

export type TimeSpanFormatInfo = Types.TimeSpanFormatInfo
export type TimeSpan = Types.TimeSpan

return table.freeze({
	DateTime = DateTime;
	DateTime2 = DateTime;
	TimeSpan = require(script.TimeSpan);
	DateTimeFormatInfo = dtfi.dt;
	TimeSpanFormatInfo = dtfi.ts;
})
