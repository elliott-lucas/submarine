## Overview

Example of a high integrity system made with SPARK Ada.

This is a simple model of a submarine which can move up and down in the water.

The aim is to ensure that the submarine does not run out of power when submerged.

Uses [`asLibraryIO`](https://bitbucket.org/anton_setzer/criticalhighintegritysystems/src/master/lib/asLibraryIO/).

## Submarine Features

The submarine can **ascend** and **descend**: 
* Moving the submarine up and down costs 1 power per metre. 
* The maximum depth is 150 metres. 

The submarine has a **hatch** which can be **opened** and **closed**: 
* The hatch must be closed before submerging (to prevent water leaking into the interior of the submarine).
* The hatch cannot be opened underwater. 

The submarine has a **battery**: 
* That can only be recharged when on the surface (as it requires air to run the generators which charge the battery). 
* The submarine will automatically resurface if it is close to not having enough fuel to resurface to prevent loss of power underwater. 
* The battery will automatically recharge when on the surface.

The submarine can only shutdown on the surface.

## Submarine Commands

The program features a command line for controlling the submarine.

The available commands are:

* `battery level` - Check the battery's charge level.
* `battery recharge` - Recharge the battery to full (on surface only).
* `hatch open` - Open the hatch (on surface only).
* `hatch close` - Close the hatch.
* `depth level` - Check the depth level of the submarine.
* `depth increase` - Increase the depth by a specified amount.
* `depth decrease` - Decrease the depth by a specified amount.
* `shutdown` - Shuts down the submarine (on surface only).
