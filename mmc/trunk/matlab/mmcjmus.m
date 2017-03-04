function [Jmus, Jmua]=mmcjmus(cfg,detp,seeds,detnum)
%
% [Jmus, Jmua]=mmcjmus(cfg,detp,seeds,detnum) (element based)
%
% Generate a time-domain Jacobian (sensitivity matrix) for scattering (mus) perturbation of a specified detector
% with configurations, detected photon seeds and detector readings from an initial MC simulation
%
% author: Ruoyang Yao (yaor <at> rpi.edu)
%         Qianqian Fang (q.fang <at> neu.edu)
%
% input:
%     cfg: the simulation configuration structure used for the initial MC simulation by mmclab
%	  detp: detector readings from the initial MC simulation
%     seeds: detected photon seeds from the initial MC simulation
%     detnum: the detector number whose detected photons will be replayed
%
% output:
%     Jmus: the Jacobian for scattering perturbation of a specified source detector pair
%		  number of rows is the number of the mesh elements
%		  number of columns is the number of time gates
%     Jmua: (optional) because calculating Jmus requires the Jacobian for mua, so one can
%           also output Jmua as a by-product.
%
% example:
%	  [cube,detp,ncfg,seeds]=mmclab(cfg);   % initial MC simulation
%	  Jmus = mmcjmus(ncfg,detp,seeds,1);    % generate scattering Jacobian of the first detector
%
% this file is part of Mesh-based Monte Carlo (MMC)
%
% License: GPLv3, see http://mcx.sf.net/mmc/ for details
%

[Jmua, newcfg]=mmcjmua(cfg,detp,seeds,detnum);

% specify output type 2
newcfg.outputtype='wp';

% replay detected photons for weighted partialpath
[jacob,detp2]=mmclab(newcfg);

% generate a map for scattering coefficient
musmap=newcfg.prop(newcfg.elemprop+1,2);

% divide by local scattering coefficient
jacob.data=jacob.data./repmat(musmap(:),1,size(jacob.data,2));

% validate if the replay is successful
if(all(ismember(round(detp.data'*1e10)*1e-10,round(detp2.data'*1e10)*1e-10,'rows')))
	%disp('replay is successful :-)');
	Jmus=Jmua+jacob.data;
else
	error('replay failed :-(');
end
