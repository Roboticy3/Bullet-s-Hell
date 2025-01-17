# Bullet's Hell Design Doc
## Overview
Bullet's Hell is a top down 2D game in which the avatar is a bullet. The goal of the game is to connect with the target. The path to the target will be impeded by various obstacles. Each obstacle will have a different impact on the avatar. There will also be power ups on the path to the target. These power ups will have different impacts on the avatar as well. The bullet will slowly lose speed over time as the avatar travels towards the target. The player beats the level if the bullet is able to connect with the target. The player loses the level if the avatar runs out of speed or is stopped by an obstacle. (we could also incorporate some type of currency that can be collected during gameplay. This currency could be then used for cosmetic upgrades to the bullet etc.)
## Mechanics
* WASD for standard movement of the bullet  
* Bullet will lose speed over time  
* Camera will follow the bullet as it shoots across the level (how close should we make the camera- what would make it feel more like you are the bullet?)  
* Obstacles will consist of various objects: Brick/ cinderblock wall- stops bullet completely (or has a very large decrease in speed value to where you would need to get a speed boost power up to make it to the target), Wooden wall- large decrease in speed, Tree- moderate decrease in speed, Bush- minimal decrease in speed (any other suggestions for obstacles?). We could have wind gust tiles and they could affect the bullet depending on the way it is blowing. For example, if the wind is blowing in the bullet's direction, it will give a speed boost, speed reduction for the other direction, or it could push the avatar left or right.  
* There will be a few types of power ups/ boosts as well. One will be a speed boost (we could have different tiers of speed boosts). Another could be an invincibility power up. If we decide to use a currency/ coins, we could have a coin magnet power up. Depending how close we have the camera, we could have a power up zoom out the camera to give the player more of a view of what's ahead. We could also have a shrink power up. (Any other suggestions?)
* Will we show the gun shooting the bullet at the beginning of each level? (Could customize guns as well)  
* Will the target be an assasination target, a terrorist, etc. or just a standard shooting target?
## Plot and Setting
* Why is the bullet going through this journey?
* What kind of enviroment is this? Will it vary with each level? Is it the countryside, or urban? Will the bullet be traveling over bodies of water, through forrests, through dense city (city wreckage, or intact cities with buildings etc.)?  
* Will this take place at night, daytime, or various times for different levels?
## Art
* Do we want a more serious tone, or more playful/ cartoony? Will probably correlate with the story and who/ what the target is.
* What kind of cosmetic customization options could we have for the bullet? Other cosmetic upgrade options?
* What kind of color palette?
## Audio
* Could do different music tracks for different types of levels?  
* At very least one track for the menu and cosmetic shop (if implemented)- more subdued, and one track for the actual gameplay- more intense (discussed including electric guitar in the instrumentation).  
* Genre/ instrumentation can shift depending on tone of the game  
* Realistic sound effects for the gunshot, impacts with obstacles and impacts with the targets. Minimal digital effect for picking up coins (if implemented). Expecting to use digital sound effects for the power ups.
## UI
* Since the theme is "you are the weapon", how can we tie this into the UI? Bullet holes, bullets as buttons, incorporate guns into the design?  
* UI color palette? Gunmetal grey with white accents? White bullet buttons? Red dot/ Green dot for a pointer?
