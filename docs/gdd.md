# Undeliverable Trajectory - Game Design Document

Student Name: Nathaniel Dizon  
Student ID: 100922330  
Date: September 25, 2026  
Class: CSCI 4160U Game Development  
Repository Link: https://github.com/HTTime39/Undeliverable-Trajectory  

## Description

My game will revolve around the theme of transporting deliveries to various locations. This will take place on another planet where the player will face challenges such as terrain, other space stuff, and dinosaurs.

## Core Gameplay Loop

### The Gameplay Loop:
The core gameplay loop will be similar to a roguelike where a player will move through a web of nodes representing terrain/encounters and passing rolls at each node to progress towards the final destination. Various encounter nodes will have either positive or negative impacts on the player which are modified by the decisions they make at each node. Most interactions will be through using the mouse using a point and click system for making decisions like what equipment to use and which node to progress to next.

### Primary Mechanics:
- The player will pick a node ahead of them and complete the scenario at each node before choosing and progressing towards the next node until they reach a final destination
- Players will be provided with a list of cargo and destinations at the beginning of a run. The cargo that they choose to take will take up both volume and weight in their inventory/bag. 
- Cargo may become damaged, lost, or in some other way impacted by various encounter nodes and their outcomes. This will have an impact on the player’s score at the end of the run.
- Each location/event node will consist of some event whose outcome will be rolled for with success and failure being determined by various factors like cargo volume, cargo weight, a stamina stat, etc.

### Secondary Mechanics:
- At the beginning of a run and/or at various nodes throughout a run, a player may choose to take on various equipment and consumables such as ladders that can modify the chance of a positive or negative outcome when making rolls at a node.
- If a player chooses to pick up equipment, similarly to cargo, it will take up space and weight in their inventory/bag.
- Players will have a stamina meter that can become depleted or recovered through various interactions with equipment or encounter nodes. The stamina meter will have an impact on various success rolls at certain nodes. 

### Tertiary Mechanics:
- When picking cargo and destinations at the beginning of a run, some will be incredibly challenging at first. As a player succeeds at easier runs, they will gain stat boosts or an increase in starting currency to purchase equipment that can make the more challenging cargo runs easier and manageable. 
- Certain pieces of equipment will have secret/unexpected interactions that players can experiment to discover and incorporate into their planning.

## MDA Framework
### Mechanics:
- Players pick cargo and equipment and manage their resources to progress through a web of encounter nodes before finally arriving at a destination. 
- A chance roll is made for interactions at an encounter node which can be modified by the player’s equipment, tools, and stats. 
- Success or failure at an encounter node will lead to various positive or negative impacts on the player that may impact their performance for the remainder of the run.
- Cargo has a condition gauge that can become depleted and have an impact on the success of a run.

### Dynamics:
- A player may choose to hoard as much equipment that their bag system allows to make later challenges easier while taking “hits” at the beginning of a run.
- A player may choose to undertake a “challenge run” and create self imposed restrictions on what they can take and do to reach the end.
- Players may choose to experiment throughout runs to determine what the optimal tradeoff between equipment and the volume/weight they take up is to more effectively plan ahead.
- A (hopefully) large sandbox of equipment, encounters, and interactions between them will lead to players creating various strategies that work best for their strategy style. 

### Aesthetics:
- Rolls and modifiers at encounter nodes will create a feeling of gambling/pushing your luck
- Equipment and limited resources/bag space makes a player feel the need to meticulously plan to the best of their knowledge for the encounters they may or may not face ahead. This also adds to the feeling of pushing your luck as you may choose the wrong items for the encounters you end up in.
- A feeling of strategic challenge is also felt to try and optimize rolls in your favour to reach the best possible outcomes for your runs. 

## Player Experience
How should they feel? (Incorporate Leblanc’s Taxonomy of pleasures):

- The player should feel the sensation of success/satisfaction and relief when their gambles pay off at encounter nodes + the end of a run. 
- A player faces the challenge of trying to plan ahead their resource usage without fully knowing what to expect in the future.
- The player should feel a sense of discovery when finding new encounter nodes they haven’t experienced before, as well when discovering new item/encounter interactions that may or may not be expected. Discovering new interactions adds to the players tool belt of ways to solve the challenges they face. 

## Game Inspirations:
- Death Stranding
- Honkai Star Rail, Simulated Universe
- For the King
- Ark Survival Evolved

## Non-Game Inspirations:
N/A

## Genre:
Strategy, Roguelike, Push your luck/gamble, RPG

## Target Audience (Incorporate Bartle’s Taxonomy):
This is primarily for achievers due to the planning/strategizing/gambling challenge presented by the game with elements that may appeal to explorers from the hidden interactions/rewards that can be discovered through the various encounter nodes.

## Progression Over Time:
The player will start with a fixed amount of health/stamina, carrying capacity, etc. that can be upgraded for subsequent runs by meeting certain criteria such as passing a certain number of encounter nodes that correspond to a particular upgrade.
Additionally, upon completing a run, the player may gain a permanent increase in their starting allotment of currency/buying power to pick items at the beginning of subsequent runs.

## Themes:
Space, dinosaurs

## Platform & Tools:
PC, Odin + Raylib, Git + GitHub, Paint3D + GIMP

## Anything else unusual that needs explaining (if applicable):
N/A
