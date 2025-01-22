## ================ Fixed Point Numbers ===============##

"""
	struct FixNumber{N,T}
		value::T

		## Constructors ##

		FixNumber{N}(v::T) where T <: Integer = new{N,T}(v)
"""
struct FixNumber{N,T}
	value::T

	## Constructors ##

	FixNumber{N}(v::T) where{N, T <: Integer} = new{N,T}(v)
	FixNumber{N,T}(v::Integer) where{N, T <: Integer} = new{N,T}(convert(T, v))

	# Create a fixed point number from a float

	FixNumber{N}(v::AbstractFloat) where{N} = begin
		@assert N > 0 "N should be a positive Integer"
	
		value = v * N

		value = ifelse(clamp, clamp(value, typemin(T), typemax(T)))
		@assert typemin(T) < v < typemax(T) "The scale factor or v is too big"

		new{N,Int}(floor(value))
	end
end

"""
	const FixNum10{N,T}

This an alisa for FixNumber{10^N,T}, these are fixed point with scales that are powers of 10.
"""
const FixNum10{N,T} = FixNumber{10^N,T}

"""
	const FixNum2{N,T}

This an alisa for FixNumber{2^N,T}, these are fixed point with scales that are powers of 2.
"""
const FixNum2{N,T} = FixNumber{2^N,T}

## ================= Helpers ================== ##