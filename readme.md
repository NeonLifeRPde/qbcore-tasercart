##
Put this In your [standalone] folder. 
Go to Server CFG and put `ensure TaserCart` in.

Go to qb-inventory/html/images and put the IMAGE in the IMAGE folder in it

Now Simply add this Item to:

qb-core/shared/items.lua

`['taser_cardridge'] = {
                    ["name"] = "taser_cardridge",
                    ["label"] = "Taser Cardridge",
                    ["weight"] = 100,
                    ["type"] = "item",
                    ["image"] = "taser_cardridge.png",
                    ["unique"] = false,
                    ["useable"] = true,
                    ["shouldClose"] = true,
                    ["combinable"] = nil,
                    ["description"] = ""
                },`