using Cairo
using Compat
using Base.Test: @test, @test_throws

surf = CairoImageSurface(100, 200, Cairo.FORMAT_ARGB32)
@test width(surf) == 100
@test height(surf) == 200
ctx = CairoContext(surf)
@test width(ctx) == 100
@test height(ctx) == 200

include("shape_functions.jl")
include("test_stream.jl")
include("tex.jl")

function test_pattern_get_surface()
    # test getting a surface from a surface pattern
    surf = CairoImageSurface(100, 200, Cairo.FORMAT_ARGB32)
    ctx = CairoContext(surf)
    Cairo.push_group(ctx)
    pattern = Cairo.pop_group(ctx)
    group_surf = Cairo.pattern_get_surface(pattern)
    @test group_surf.width == 100
    @test group_surf.height == 200

    # test that surfaces can't be gotten from non-surface patterns
    pattern = Cairo.pattern_create_linear(0, 0, 100, 200)
    @test_throws ErrorException Cairo.pattern_get_surface(pattern)
end

test_pattern_get_surface()
