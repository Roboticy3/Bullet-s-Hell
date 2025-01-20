# Bullet's Hell Design Doc
## Overview
Bullet's Hell is a top down 2D game in which the avatar is a bullet. The goal of the game is to connect with the assassination target. Depending on the difficulty of the level there are one or more target(s). The path to the target is be impeded by various obstacles. There are also be power ups on the path to the target. The bullet slowly loses speed over time as the avatar travels towards the target. The player beats the level if the bullet is able to connect with the target(s). The player loses the level if the avatar runs out of speed or is stopped by an obstacle. There are coins that can be collected in the gamespace as additional incentive during the gameplay. Additionally, a set number of coins are earned depending on the amount of time it takes to eliminate the target(s). There is a cosmetics shop for the player to spend their coins on. There are three settings (beach, town, and forrest) that each level takes place in. Each setting is be reused for different level designs.
## Mechanics
* WASD, or LR arrow keys, or mouse for avatar movement. 
* Bullet loses speed over time  
* Camera follows the bullet as it shoots across the level. The camera zooms with relation to the bullet's speed. Faster speed it zooms out, and slower speed it zooms in.  
* Obstacles consist of various objects: Brick/ cinderblock wall- stops bullet completely, Wooden wall/fence- large decrease in speed, Tree branches- moderate decrease in speed, Bush- minimal decrease in speed. Wind gust tiles- affect the bullet depending on the way it is blowing. For example, if the wind is blowing in the bullet's direction, it will give a speed boost, speed reduction for the other direction, or it will push the avatar left or right for those respective wind directions. Mirror/bouncy material- when the bullet hits the object at closer to a 90 degree (perpendicular) angle, the bullet loses speed like a standard obstacle. When the bullet hits the object at closer to a 0 degree (parallel) angle the bullet reflects off the surface, while also gaining a speed boost.  
* There are be a few types of power ups/ boosts as well. One will be a speed boost (we could have different tiers of speed boosts). Another is an invincibility/digging/teleport/blink power up. There is also a coin magnet power up. Another power up is the shrink power up. The Mirror/bouncy material is also a power up because of the boost acquired if used correctly.
* There is also an ultimate power up that the user charges up and can use once fully charged. It currently an obstacle destroying missile that can clear a path in front of the player.
* A nine mm pistol shoots the bullet to begin the round. (Could have a minigame where player has to press the right key at the right time to get a boost at the beginning of the level)  
* The target(s) are assassination target(s). First people are the targets, then other bullets become targets as well. The final boss is a bullet that moves away from the avatar
* The player is able to collect coins and then spend them on cosmetics to customize the avatar.
* There are navigation tools to aid the player in finding the target. There is an arrow pointing the player in the direction of the target. There is also a path tracker/ minimap used for showing the player their path.
## Plot and Setting
* The player character is a sentient bullet who is receiving assination missions. These missions first come from people, then other bullets.
* This game will take place in a town. The town, the beach, and the forrest are the settings for all of the levels. The town is located next a forrest on a lake and the lake has a beach, so each of these locations are connected to the central town.
* There have multiple times of day in which the events of the game take place.
## Art
* The game has a simple, cartoonish, pixel art style to contrast the seriousness of the story.
* The cosmetic customization options are bullet colors, bullet trails, and clothing/ accessories.
* The color palette is darker, noir and realistic.
## Audio
* Each level setting has it's own track- A city theme, a beach theme, and a forrest theme. There is also a boss level theme for the final boss level. The music is fast paced and a bit on the intense side
* There is also a track for the main menu and the cosmetics shop. This is a track will be slower and more subdued compared to the level tracks.  
* Realistic sound effects for the gunshot, impacts with obstacles, impacts with the targets, and coins. Button click in the menu is racking a gun. Digital sound effects are used for the power ups.
## UI
* Bullet holes are on the menu and bullets are the buttons.  
* UI color palette is Gunmetal grey with white accents. The buttons are white bullet buttons. A red dot is used for the mouse pointer.
