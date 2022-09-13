##
Put this In your [standalone] folder. 
Go to Server CFG and put `ensure TaserCart` in.

Go to qb-inventory/html/images and put the `taser_cardridge.png` in it

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

Credits: 𝙻𝚎𝚐𝚎𝚗𝚍𝚇𝙸#7926
