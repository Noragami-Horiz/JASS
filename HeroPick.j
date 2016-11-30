library HeroPick initializer Init requires BJObjectId, Polygon, PolygonUtils, UnitRecycler
globals
    private Polygon poly
    private unit array hero
    private real array heroX
    private real array heroY
    private real array heroFace
endglobals

globals
    //Distance between 2nd and 3rd columns
    //b stands for back to back
    private real bOffset = 374
    //The distance between heroes in a column
    private real yOffset = 369
    //The distance between the first column and the second
    private real xOffset = 1154
    //Coords of reference point(1st Pick Location)
    private real yOrigin = -8122
    private real xOrigin = -2754
    //Circle of Power as the method for picking
    private integer circle = 'ncop'
    private string cModel = "buildings\\other\\CircleOfPower\\CircleOfPower.mdl"
    private real cOffset = 163
    //The columns with statue
    private real xTop = -2190
    private real yTop = -6564
    //The leftover columns
    private real xLeft = -838
    private real yLeft = -6953
    //The leftover columns on Hell side
    private real xhLeft = 443
    //Unit Type Id for selector
    private integer LOST_SOUL = 'e000'
endglobals

private function GetHero takes nothing returns nothing
    local integer uid
    if GetOwningPlayer(hero[Polygon.object]) == Player(15) then
        call SetUnitOwner(hero[Polygon.object], GetOwningPlayer(Polygon.unit), true)
        if GetUnitTypeId(Polygon.unit) == LOST_SOUL then
            call RecycleUnit(Polygon.unit)
        else
            call SetUnitOwner(Polygon.unit, Player(15), true)
            set uid = GetUnitUserData(Polygon.unit)
            call SetUnitX(heroX[uid])
            call SetUnitY(heroY[uid])
            call SetUnitFacing(heroFace[uid])
        endif
    endif
endfunction

private function CreateHero takes nothing returns nothing
    local BJObjectId oid = BJObjectId('U000')
    local BJObjectId last_oid = BJObjectId('U003')
    local real x = xOrigin
    local real y = yOrigin
    local integer uid
    
    //Create first column of heroes
    loop
        exitwhen oid > last_oid
        call AddSpecialEffect(cModel, x + cOffset, y)
        set poly = Polygon.create()
        call poly.addVertex(x + cOffset + 64, y + 64)
        call poly.addVertex(x + cOffset - 64, y + 64)
        call poly.addVertex(x + cOffset - 64, y - 64)
        call poly.addVertex(x + cOffset + 64, y - 64)
        call poly.finalize()
        call poly.registerEnter(function GetHero)
        set hero[poly] = CreateUnit(Player(15), oid, x, y, 0)
        set uid = GetUnitUserData(hero[poly])
        set heroX[uid] = GetUnitX(hero[poly])
        set heroY[uid] = GetUnitY(hero[poly])
        set heroFace[uid] = GetUnitFacing(hero[poly])
        call AddLightningToPolygon("DRAM", poly)
        set y = y + yOffset
        set oid = oid.plus_1()
    endloop
    
    //Create heroes next to statue
    call AddSpecialEffect(cModel, xTop, yTop - cOffset)
    set poly = Polygon.create()
    call poly.addVertex(xTop + 64, yTop - cOffset + 64)
    call poly.addVertex(xTop - 64, yTop - cOffset + 64)
    call poly.addVertex(xTop - 64, yTop - cOffset - 64)
    call poly.addVertex(xTop + 64, yTop - cOffset - 64)
    call poly.finalize()
    call poly.registerEnter(function GetHero)
    set hero[poly] = CreateUnit(Player(15), 'U004', xTop, yTop, 270)
    set uid = GetUnitUserData(hero[poly])
    set heroX[uid] = GetUnitX(hero[poly])
    set heroY[uid] = GetUnitY(hero[poly])
    set heroFace[uid] = GetUnitFacing(hero[poly])
    call AddLightningToPolygon("DRAM", poly)
    call AddSpecialEffect(cModel, -xTop, yTop - cOffset)
    set poly = Polygon.create()
    call poly.addVertex(-xTop + 64, yTop - cOffset + 64)
    call poly.addVertex(-xTop - 64, yTop - cOffset + 64)
    call poly.addVertex(-xTop - 64, yTop - cOffset - 64)
    call poly.addVertex(-xTop + 64, yTop - cOffset - 64)
    call poly.finalize()
    call poly.registerEnter(function GetHero)
    set hero[poly] = CreateUnit(Player(15), 'U023', -xTop, yTop, 270)
    set uid = GetUnitUserData(hero[poly])
    set heroX[uid] = GetUnitX(hero[poly])
    set heroY[uid] = GetUnitY(hero[poly])
    set heroFace[uid] = GetUnitFacing(hero[poly])
    call AddLightningToPolygon("DRAM", poly)
    
    //Create second column of heroes
    set oid = BJObjectId('U005')
    set last_oid = BJObjectId('U008')
    set y = y - yOffset
    set x = x + xOffset
    loop
        exitwhen oid > last_oid
        call AddSpecialEffect(cModel, x - cOffset, y)
        set poly = Polygon.create()
        call poly.addVertex(x - cOffset + 64, y - 64)
        call poly.addVertex(x - cOffset - 64, y - 64)
        call poly.addVertex(x - cOffset - 64, y + 64)
        call poly.addVertex(x - cOffset + 64, y + 64)
        call poly.finalize()
        call poly.registerEnter(function GetHero)
        set hero[poly] = CreateUnit(Player(15), oid, x, y, 180)
        set uid = GetUnitUserData(hero[poly])
        set heroX[uid] = GetUnitX(hero[poly])
        set heroY[uid] = GetUnitY(hero[poly])
        set heroFace[uid] = GetUnitFacing(hero[poly])
        call AddLightningToPolygon("DRAM", poly)
        set y = y - yOffset
        set oid = oid.plus_1()
    endloop
    
    //Create third column of heroes
    set oid = BJObjectId('U009')
    set last_oid = BJObjectId('U011')
    set y = y + yOffset
    set x = x + bOffset
    loop
        exitwhen oid > last_oid
        if oid == 'U009' or oid == 'U010' or oid == 'U011' then 
            call AddSpecialEffect(cModel, x + cOffset, y)
            set poly = Polygon.create()
            call poly.addVertex(x + cOffset + 64, y + 64)
            call poly.addVertex(x + cOffset - 64, y + 64)
            call poly.addVertex(x + cOffset - 64, y - 64)
            call poly.addVertex(x + cOffset + 64, y - 64)
            call poly.finalize()
            call poly.registerEnter(function GetHero)
            set hero[poly] = CreateUnit(Player(15), oid, x, y, 0)
            set uid = GetUnitUserData(hero[poly])
            set heroX[uid] = GetUnitX(hero[poly])
            set heroY[uid] = GetUnitY(hero[poly])
            set heroFace[uid] = GetUnitFacing(hero[poly])
            call AddLightningToPolygon("DRAM", poly)
            set y = y + yOffset
        endif
        set oid = oid.plus_1()
    endloop
    
    //Create the leftovers
    call AddSpecialEffect(cModel, xLeft, yLeft - cOffset)
    set poly = Polygon.create()
    call poly.addVertex(xLeft + 64, yLeft - cOffset + 64)
    call poly.addVertex(xLeft - 64, yLeft - cOffset + 64)
    call poly.addVertex(xLeft - 64, yLeft - cOffset - 64)
    call poly.addVertex(xLeft + 64, yLeft - cOffset - 64)
    call poly.finalize()
    call poly.registerEnter(function GetHero)
    set hero[poly] = CreateUnit(Player(15), 'U012', xLeft, yLeft, 270)
    set uid = GetUnitUserData(hero[poly])
    set heroX[uid] = GetUnitX(hero[poly])
    set heroY[uid] = GetUnitY(hero[poly])
    set heroFace[uid] = GetUnitFacing(hero[poly])
    call AddLightningToPolygon("DRAM", poly) 
    call AddSpecialEffect(cModel, xLeft + yOffset, yLeft - cOffset)
    set poly = Polygon.create()
    call poly.addVertex(xLeft + yOffset + 64, yLeft - cOffset + 64)
    call poly.addVertex(xLeft + yOffset - 64, yLeft - cOffset + 64)
    call poly.addVertex(xLeft + yOffset - 64, yLeft - cOffset - 64)
    call poly.addVertex(xLeft + yOffset + 64, yLeft - cOffset - 64)
    call poly.finalize()
    call poly.registerEnter(function GetHero)
    set hero[poly] = CreateUnit(Player(15), 'U013', xLeft + yOffset, yLeft, 270)
    set uid = GetUnitUserData(hero[poly])
    set heroX[uid] = GetUnitX(hero[poly])
    set heroY[uid] = GetUnitY(hero[poly])
    set heroFace[uid] = GetUnitFacing(hero[poly])
    call AddLightningToPolygon("DRAM", poly)
    
    //Do the same for Hell heroes 
    call AddSpecialEffect(cModel, xhLeft, yLeft - cOffset)
    set poly = Polygon.create()
    call poly.addVertex(xhLeft + 64, yLeft - cOffset + 64)
    call poly.addVertex(xhLeft - 64, yLeft - cOffset + 64)
    call poly.addVertex(xhLeft - 64, yLeft - cOffset - 64)
    call poly.addVertex(xhLeft + 64, yLeft - cOffset - 64)
    call poly.finalize()
    call poly.registerEnter(function GetHero)
    set hero[poly] = CreateUnit(Player(15), 'U014', xhLeft, yLeft, 270)
    set uid = GetUnitUserData(hero[poly])
    set heroX[uid] = GetUnitX(hero[poly])
    set heroY[uid] = GetUnitY(hero[poly])
    set heroFace[uid] = GetUnitFacing(hero[poly])
    call AddLightningToPolygon("DRAM", poly)
    call AddSpecialEffect(cModel, xhLeft + yOffset, yLeft - cOffset)
    set poly = Polygon.create()
    call poly.addVertex(xhLeft + yOffset + 64, yLeft - cOffset + 64)
    call poly.addVertex(xhLeft + yOffset - 64, yLeft - cOffset + 64)
    call poly.addVertex(xhLeft + yOffset - 64, yLeft - cOffset - 64)
    call poly.addVertex(xhLeft + yOffset + 64, yLeft - cOffset - 64)
    call poly.finalize()
    call poly.registerEnter(function GetHero)
    set hero[poly] = CreateUnit(Player(15), 'U015', xhLeft + yOffset, yLeft, 270)
    set uid = GetUnitUserData(hero[poly])
    set heroX[uid] = GetUnitX(hero[poly])
    set heroY[uid] = GetUnitY(hero[poly])
    set heroFace[uid] = GetUnitFacing(hero[poly])
    call AddLightningToPolygon("DRAM", poly)
    
    //1st next to column with statue
    set oid = BJObjectId('U027')
    set last_oid = BJObjectId('U024')
    set x = -xOrigin
    set y = yOrigin
    loop
        exitwhen oid < last_oid
        call AddSpecialEffect(cModel, x - cOffset, y)
        set poly = Polygon.create()
        call poly.addVertex(x - cOffset + 64, y + 64)
        call poly.addVertex(x - cOffset - 64, y + 64)
        call poly.addVertex(x - cOffset - 64, y - 64)
        call poly.addVertex(x - cOffset + 64, y - 64)
        call poly.finalize()
        call poly.registerEnter(function GetHero)
        set hero[poly] = CreateUnit(Player(15), oid, x, y, 180)
        set uid = GetUnitUserData(hero[poly])
        set heroX[uid] = GetUnitX(hero[poly])
        set heroY[uid] = GetUnitY(hero[poly])
        set heroFace[uid] = GetUnitFacing(hero[poly])
        call AddLightningToPolygon("DRAM", poly)
        set y = y + yOffset
        set oid = oid.minus_1()
    endloop
    
    //2nd
    set oid = BJObjectId('U022')
    set last_oid = BJObjectId('U019')
    set x = x - xOffset
    set y = y - yOffset
    loop
        exitwhen oid < last_oid
        if oid == 'U022' or oid == 'U021' or oid == 'U020' or oid == 'U019' then
            call AddSpecialEffect(cModel, x + cOffset, y)
            set poly = Polygon.create()
            call poly.addVertex(x + cOffset + 64, y + 64)
            call poly.addVertex(x + cOffset - 64, y + 64)
            call poly.addVertex(x + cOffset - 64, y - 64)
            call poly.addVertex(x + cOffset + 64, y - 64)
            call poly.finalize()
            call poly.registerEnter(function GetHero)
            set hero[poly] = CreateUnit(Player(15), oid, x, y, 0)
            set uid = GetUnitUserData(hero[poly])
            set heroX[uid] = GetUnitX(hero[poly])
            set heroY[uid] = GetUnitY(hero[poly])
            set heroFace[uid] = GetUnitFacing(hero[poly])
            call AddLightningToPolygon("DRAM", poly)
            set y = y - yOffset
        endif
        set oid = oid.minus_1()
    endloop
    
    //3rd
    set oid = BJObjectId('U018')
    set last_oid = BJObjectId('U016')
    set x = x - bOffset
    set y = y + yOffset
    loop
        exitwhen oid < last_oid
        call AddSpecialEffect(cModel, x - cOffset, y)
        set poly = Polygon.create()
        call poly.addVertex(x - cOffset + 64, y + 64)
        call poly.addVertex(x - cOffset - 64, y + 64)
        call poly.addVertex(x - cOffset - 64, y - 64)
        call poly.addVertex(x - cOffset + 64, y - 64)
        call poly.finalize()
        call poly.registerEnter(function GetHero)
        set hero[poly] = CreateUnit(Player(15), oid, x, y, 180)
        set uid = GetUnitUserData(hero[poly])
        set heroX[uid] = GetUnitX(hero[poly])
        set heroY[uid] = GetUnitY(hero[poly])
        set heroFace[uid] = GetUnitFacing(hero[poly])
        call AddLightningToPolygon("DRAM", poly)
        set y = y + yOffset
        set oid = oid.minus_1()
    endloop
endfunction

private function Init takes nothing returns nothing
    call TimerStart(CreateTimer(), 2.00, false, function CreateHero)
endfunction
endlibrary

