$fn = 48;

difference() {
	union() {
		linear_extrude(height = 22.5000000000, scale = 1.2000000000, slices = 1.0000000000, twist = 10) {
			circle($fn = 8, r = 27);
		}
		translate(v = [0, 0, 45]) {
			rotate(a = [180, 0, -20]) {
				linear_extrude(height = 22.5000000000, scale = 1.2000000000, slices = 1.0000000000, twist = 10) {
					circle($fn = 8, r = 27);
				}
			}
		}
	}
	translate(v = [0, 0, 9.0000000000]) {
		rotate(a = -20) {
			cylinder($fn = 8, h = 45, r = 22.9500000000);
		}
	}
}
/***********************************************
*********      SolidPython code:      **********
************************************************
 
#! /usr/bin/env python
# -*- coding: UTF-8 -*-
from __future__ import division
import os
import sys
import re

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

def shell(params):
    height = params['height']
    min_radius = params['radius']
    max_radius = min_radius * 1.2
    twist = params['twist']
    segments = params['segments']
    slices = params['slices']
    
    shape= circle(r=min_radius, segments=segments)
    obj = linear_extrude(height=height/2, twist=twist, slices=slices/2, scale=max_radius/min_radius)(shape)

    obj_mirror = up(height)(
        rotate([180,0,-2*twist])(
            obj
        )
    )

    return obj + obj_mirror

def inside(params):
    height = params['height']
    radius = params['radius'] * 0.85
    twist = params['twist']
    segments = params['segments']

    shape = cylinder(h=height, r=radius, segments=segments)

    return up(height*0.2)(rotate(-2*twist)(shape))

def assembly():
    params = {
        'height' : 45,
        'radius' : 27,
        'segments' : 8,
        'slices' : 2,
        'twist' : 10
    }

    return shell(params) - inside(params)

if __name__ == '__main__':
    use('./list-comprehension-demos/sweep.scad')

    a = assembly()
    scad_render_to_file(
        a,
        'out.scad',
        file_header='$fn = %s;' % SEGMENTS,
        include_orig_code=True
    )
 
 
************************************************/
