module Categories

export Category, Ob, Morphism, Hom, category, label, domain, codomain, compose

# struct Category{O,L} end
# Category(L,::Type{O}) where {O} = Category{O,L}

# obtype(::Category{O}) where {O} = O
# label(::Category{O,L}) where {O,L} = L

struct Object{O,N,L}
    object::NTuple{N,O}
end

struct Morphism{O,N,L}
    morphism::NTuple{N,<:Function}
    domain::Object{O}
    codomain::Object{O}
end
Morphism(dom::Object{O},codom::Object{O},L) where {O} = Morphism{O,L}(dom,codom)

id(obj::Object) = obj

struct Category{O,L}
    ob::Type{<:Object{O}}
    hom::Type{<:Morphism{O}}
end

# struct Ob{O,N} 
#     object::NTuple{N,<:Object{O}}
# end
# Ob(::Type{C},ob::NTuple{N,O}) where {N,O,C<:Category{O}} = Ob{O,C,N}(ob)
# Ob(::Type{C},ob::O) where {O,C<:Category{O}} = Ob{O,C,1}((ob,))
# Ob(::Type{C}) where {O,C<:Category{O}} = Ob{O,C}

# struct Hom{O,C<:Category{O},N}
#     morphism::NTuple{N,<:Morphism{O}}
# end

# obtype(::Ob{O}) where {O} = O
# category(::Ob{O,C}) where {O,C} = C
# nproducts(::Ob{O,C,N}) where {O,C,N} = N

# function morphism end

# struct Hom{O,C<:Category{O},N}
#     morphism::NTuple{N,<:Morphism{O}}
# end


# # Hom(dom::Ob{O,C},codom::Ob{O,C},m::NTuple{N,<:Morphism}) where {O,C,N} = Hom{(dom,codom),C,N}(dom,codom,m)
# Hom(dom::Ob{O,C},codom::Ob{O,C},L::Symbol) where {O,C} = Hom{O,C,1}((Morphism(dom,codom,L),))
# Hom(dom::Ob{O,C},codom::Ob{O,C}) where {O,C} = Hom{(dom,codom)}
# Hom(::C) where {O,C<:Category{O}} = Hom{O,C}

# category(::Hom{C}) where {C} = C
# domain(::Hom{C,T}) where {C,T} = T[1]
# codomain(::Hom{C,T}) where {C,T} = T[2]
# label(::Hom{C,T,L}) where {C,T,L} = L

# function compose(::Hom{C,T1,L1},::Hom{C,T2,L2}) where {C,T1,T2,L1,L2}
#     T1[2] == T2[1] || error("Domain mismath")
#     return Hom{C,(T1[1],T2[2]),(L1...,L2...)}()
# end

# Base.in(::Ob{C1},::Type{<:Ob{C2}}) where {C1<:Category,C2<:Category} = C1 === C2

# Base.in(::Hom{C1,T1},::Type{<:Hom{C2,T2}}) where {C1<:Category,C2<:Category,T1,T2} = (C1 === C2) && (T1 === T2)

# Base.in(::Hom{C1},::Type{<:Hom{C2}}) where {C1<:Category,C2<:Category} = (C1 === C2)

end # module