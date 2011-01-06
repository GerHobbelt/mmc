/*******************************************************************************
**  Mesh-based Monte Carlo (MMC)
**
**  Author: Qianqian Fang <fangq at nmr.mgh.harvard.edu>
**
**  Reference:
**  (Fang2010) Qianqian Fang, "Mesh-based Monte Carlo Method Using Fast Ray-Tracing 
**          in Pl�cker Coordinates," Biomed. Opt. Express, 1(1) 165-175 (2010)
**
**  (Fang2009) Qianqian Fang and David A. Boas, "Monte Carlo Simulation of Photon 
**          Migration in 3D Turbid Media Accelerated by Graphics Processing 
**          Units," Optics Express, 17(22) 20178-20190 (2009)
**
**  License: GPL v3, see LICENSE.txt for details
**
*******************************************************************************/

/***************************************************************************//**
\file    tettracing.h

\brief   Definition of the core ray-tracing functions
*******************************************************************************/

#ifndef _MMC_RAY_TRACING_H
#define _MMC_RAY_TRACING_H

#include "simpmesh.h"
#include "mcx_utils.h"

#define MAX_TRIAL          3
#define FIX_PHOTON         1e-3f

void interppos(float3 *w,float3 *p1,float3 *p2,float3 *p3,float3 *pout);
void getinterp(float w1,float w2,float w3,float3 *p1,float3 *p2,float3 *p3,float3 *pout);
void fixphoton(float3 *p,float3 *nodes, int *ee);
float onephoton(int id,raytracer *tracer,tetmesh *mesh,mcconfig *cfg,float rtstep,RandType *ran,RandType *ran0,float *raytri);
float reflectray(mcconfig *cfg,float3 *c0,raytracer *tracer,int *oldeid,int *eid,int faceid,RandType *ran);
inline float mmc_rsqrtf(float a);

#endif