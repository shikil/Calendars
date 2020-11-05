module Calendars
import Base.show
import Printf.@sprintf
using Dates
export Calendar

struct Calendar
	day::Date
	days::Vector{Int}
	function Calendar()
		day = firstdayofmonth(today())
		Calendar(year(day), month(day))
	end
	function Calendar(year, month)
		day = Date(year, month, 1)
		days = vcat(fill(0, dayofweek(day) % 7), 1:dayofmonth(lastdayofmonth(day)))
		new(day, days)
	end
end

function center(str, fillstr, width)
	l = length(str)
	l > width && return str
	i = div(width - l, 2)
	return fillstr^i * str * fillstr^(width - l - i)
end

format(day) = day == 0 ? "   " : @sprintf "%3d" day

function show(io::IO, ::MIME"text/plain", x::Calendar)
	println(io, center("$(monthname(x.day))-$(year(x.day))", "_", 21))
	println(io, " Su Mo Tu We Th Fr Sa")
	for (index, value) in enumerate(x.days)
		printstyled(io, format(value); color=0 <= index % 7 <= 1 ? :red : :normal)
		index % 7 == 0 && println()
	end
end

end # module
