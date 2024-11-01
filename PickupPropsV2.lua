local holdingEntity = false
local holdingCarEntity = false
local holdingPed = false
local heldEntity = nil
local entityType = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if holdingEntity and heldEntity then
            local playerPed = PlayerPedId()
            local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
            DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[Y] Drop Entity / [U] Attach Ped")
            if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                RequestAnimDict('anim@mp_rollarcoaster')
                while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
            elseif (holdingPed or not holdingCarEntity) and not IsEntityPlayingAnim(playerPed, 'anim@heists@box_carry@', 'idle', 3) then
                RequestAnimDict('anim@heists@box_carry@')
                while not HasAnimDictLoaded('anim@heists@box_carry@') do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, -1, 50, 0, false, false, false)
            end

            if not IsEntityAttached(heldEntity) then
                holdingEntity = false
                holdingCarEntity = false
                holdingPed = false
                heldEntity = nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local camPos = GetGameplayCamCoord()
        local camRot = GetGameplayCamRot(2)
        local direction = RotationToDirection(camRot)
        local dest = vec3(camPos.x + direction.x * 10.0, camPos.y + direction.y * 10.0, camPos.z + direction.z * 10.0)

        local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, -1, playerPed, 0)
        local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)
        local validTarget = false

        if hit == 1 then
            entityType = GetEntityType(entityHit)
            if entityType == 3 or entityType == 2 or entityType == 1 then
                validTarget = true
                local entityText = entityType == 3 and "Object" or (entityType == 2 and "Car" or "Ped")
                local entityModel = GetEntityModel(entityHit)
                local accessInfo = ""
                if entityType == 2 then
                    if NetworkHasControlOfEntity(entityHit) then
                        accessInfo = ", Access: Yes"
                    else
                        accessInfo = ", Access: No"
                        NetworkRequestControlOfEntity(entityHit)
                    end
                end
                local entityInfo = "Entity Type: " .. entityText .. ", Entity: " .. entityHit .. ", Model: " .. entityModel .. accessInfo
                local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, entityInfo)
            end
        end

        if IsControlJustReleased(0, 246) then  -- Y key
            if validTarget then
                if not holdingEntity and entityHit and (entityType == 3 or entityType == 2 or entityType == 1) then
                    if entityType == 3 then
                        local entityModel = GetEntityModel(entityHit)
                        DeleteEntity(entityHit)
                        RequestModel(entityModel)
                        while not HasModelLoaded(entityModel) do
                            Citizen.Wait(100)
                        end

                        local clonedEntity = CreateObject(entityModel, camPos.x, camPos.y, camPos.z, true, true, true)
                        SetModelAsNoLongerNeeded(entityModel)
                        holdingEntity = true
                        heldEntity = clonedEntity
                        RequestAnimDict("anim@heists@box_carry@")
                        while not HasAnimDictLoaded("anim@heists@box_carry@") do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                        AttachEntityToEntity(clonedEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                    elseif entityType == 2 then
                        holdingEntity = true
                        holdingCarEntity = true
                        heldEntity = entityHit
                        RequestAnimDict('anim@mp_rollarcoaster')
                        while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                        AttachEntityToEntity(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                    elseif entityType == 1 then
                        holdingEntity = true
                        holdingPed = true
                        heldEntity = entityHit
                        RequestAnimDict('anim@heists@box_carry@')
                        while not HasAnimDictLoaded('anim@heists@box_carry@') do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                        
                        -- Move the ped closer to the player
                        local playerCoords = GetEntityCoords(playerPed)
                        local pedCoords = GetEntityCoords(heldEntity)
                        local newPedCoords = vector3(playerCoords.x, playerCoords.y, playerCoords.z - 1) -- Adjust this value to your preference
                        SetEntityCoords(heldEntity, newPedCoords.x, newPedCoords.y, newPedCoords.z, false, false, false, false)

                        -- Clear the ped's tasks
                        ClearPedTasksImmediately(heldEntity)

                        -- Attach the ped to the player
                        AttachEntityToEntity(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                    end
                end
            else
                if holdingEntity and (holdingCarEntity or holdingPed) then
                    holdingEntity = false
                    holdingCarEntity = false
                    holdingPed = false
                    ClearPedTasks(playerPed)
                    DetachEntity(heldEntity, true, true)
                    ApplyForceToEntity(heldEntity, 1, direction.x * 500, direction.y * 500, direction.z * 500, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                elseif holdingEntity then
                    holdingEntity = false
                    ClearPedTasks(playerPed)
                    DetachEntity(heldEntity, true, true)
                    local playerCoords = GetEntityCoords(playerPed)
                    SetEntityCoords(heldEntity, playerCoords.x, playerCoords.y, playerCoords.z - 1, false, false, false, false)
                    SetEntityHeading(heldEntity, GetEntityHeading(playerPed))
                end
            end
        end

        -- Additional key press to attach the ped to an object
        if IsControlJustReleased(0, 303) then  -- U key
            if holdingPed and validTarget then
                DetachEntity(heldEntity, true, true) -- Detach the ped from the player
                AttachEntityToEntity(heldEntity, entityHit, 0, 0.0, 0.0, 1.5, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                FreezeEntityPosition(heldEntity, true) -- Freeze the ped's position
                TaskStartScenarioInPlace(heldEntity, "WORLD_HUMAN_PARTYING", 0, true) -- Make the ped dance
                holdingPed = false  -- Reset holdingPed flag
                heldEntity = nil    -- Clear heldEntity
            end
        end
    end
end)

function RotationToDirection(rotation)
    local adjustedRotation = vec3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vec3(-math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.sin(adjustedRotation.x))
    return direction
end

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = (1 / GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 155)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
