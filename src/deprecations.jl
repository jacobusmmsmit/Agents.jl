# Some deprecations exist in submodules Pathfinding, OSM

@deprecate edistance euclidean_distance
@deprecate rem_node! rem_vertex!
@deprecate add_node! add_vertex!

function ContinuousSpace(extent, spacing; kwargs...)
    @warn "Specifying `spacing` by position is deprecated. Use keyword `spacing` instead."
    return ContinuousSpace(extent; spacing=spacing, kwargs...)
end

"""
    seed!(model [, seed])

Reseed the random number pool of the model with the given seed or a random one,
when using a pseudo-random number generator like `MersenneTwister`.
"""
function seed!(model::ABM, args...)
    @warn "`seed!(model::ABM, ...)` is deprecated. Do `seed!(abmrng(model), ...)`."
    return Random.seed!(abmrng(model), args...)
end

# From before the move to an interface for ABMs and making `ABM` abstract.
AgentBasedModel(args...; kwargs...) = SingleContainerABM(args...; kwargs...)

"""
    walk!(agent, rand, model)

Invoke a random walk by providing the `rand` function in place of
`direction`. For `AbstractGridSpace`, the walk will cover ±1 positions in all directions,
`ContinuousSpace` will reside within [-1, 1].

This functionality is deprecated. Use [`randomwalk!`](@ref) instead.
"""
function walk!(agent, ::typeof(rand), model::ABM{<:AbstractGridSpace{D}}; kwargs...) where {D}
    @warn "Producing random walks through `walk!` is deprecated. Use `randomwalk!` instead."
    return walk!(agent, Tuple(rand(model.rng, -1:1, D)), model; kwargs...)
end

function walk!(agent, ::typeof(rand), model::ABM{<:ContinuousSpace{D}}) where {D}
    @warn "Producing random walks through `walk!` is deprecated. Use `randomwalk!` instead."
    return walk!(agent, Tuple(2.0 * rand(model.rng) - 1.0 for _ in 1:D), model)
end
