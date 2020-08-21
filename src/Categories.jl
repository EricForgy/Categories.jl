module Categories

export Category, Object, Morphism, Composition, category, ob, hom, id, label, domain, codomain, compose

struct Object{O}
    object::O
end

obtype(::Object{O}) where {O} = O

abstract type AbstractMorphism{O,M} end

obtype(::AbstractMorphism{O}) where {O} = O

homtype(::AbstractMorphism{O,M}) where {O,M} = M

struct Id{O,M} <: AbstractMorphism{O,M} end
(id::Id{O})(x::O) where {O} = x

struct Morphism{O,M} <: AbstractMorphism{O,M}
    morphism::M
    domain::Object{O}
    codomain::Object{O}
end

morphism(m::Morphism) = m.morphism

domain(m::Morphism) = m.domain

codomain(m::Morphism) = m.codomain

struct Composition{O,M,N} <: AbstractMorphism{O,M}
    morphisms::NTuple{N,Morphism{O,M}}
end

domain(c::Composition) = first(c.morphisms).domain

codomain(c::Composition) = last(c.morphisms).codomain

struct Category{O,M}
    ob::Type{Object{O}}
    hom::Type{Morphism{O,M}}
    id::Id{O,M}
end

Category(::Type{O},::Type{M}) where {O,M} = Category{O,M}(Object{O},Morphism{O,M},Id{O,M}())

ob(C::Category) = C.ob

hom(C::Category)= C.hom

id(C::Category) = C.id

Base.in(::Object{O1}, ::Type{Object{O2}}) where {O1,O2} = O1 <: O2

Base.in(::AbstractMorphism{O1,M1}, ::Type{Morphism{O2,M2}}) where {O1,O2,M1,M2} = (O1 <: O2) && (M1 <: M2)

Base.in(::AbstractMorphism{O1,M1}, ::Object{O2}, ::Object{O2}) where {O1,O2,M1,M2} = (O1 <: O2) && (M1 <: M2)

function compose(m1::Morphism{O,M},m2::Morphism{O,M}) where {O,M}
    m1.codomain === m2.domain || error("Domain mismatch")
    return Composition((m1,m2))
end

function compose(m::Morphism{O,M},c::Composition{O,M}) where {O,M}
    m.codomain === domain(c) || error("Domain mismatch")
    Composition((m,c.morphisms...))
end

function compose(c::Composition{O,M},m::Morphism{O,M}) where {O,M}
    codomain(c) === m.domain || error("Domain mismatch")
    Composition((c.morphisms...,m))
end

compose(m::AbstractMorphism{O,M},::Id{O,M}) where {O,M} = m

compose(::Id{O,M},m::AbstractMorphism{O,M}) where {O,M} = m

Base.:∘(m1::AbstractMorphism,m2::AbstractMorphism) = compose(m1,m2)

function (comp::Composition{O})(x::O) where {O}
    domain(comp).object === x || error("Domain mismatch")
    for mor in comp.morphisms
        x = mor(x)
    end
    return x
end

Base.show(io::IO, obj::Object) = print(io, obj.object)

Base.show(io::IO, mor::Morphism) = print(io, mor.morphism, ": ", mor.domain," → ", mor.codomain)

function Base.show(io::IO, comp::Composition)
    print(
        io,
        join(morphism.(comp.morphisms)," ∘ "),
        ": ",
        domain(first(comp.morphisms)),
        " → ",
        codomain(last(comp.morphisms))
    )
end

end # module