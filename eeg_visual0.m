function hfig=eeg_visual(EEG,f,labels,lines)
%
%  Plot EEG data
%
%  @file eeg_visual.m 
%  
%  Plot of EEG data, with the possibility to plot vertical lines
%
%
%  eeg_visual(EEG,f,labels,lines)
%
%  Inputs: 
%
%        EEG:             EEG matrix
%
%        f (in Hz):       sampling frequency
%
%        labels:          labels of the channels
%
%        lines (in s):    position of vertical lines 
%
%
%  Outputs:               
%
%       hfig:             figure handle
%
%      
%  Elodie M Lopes, Brain group, INESC-TEC Porto, Oct/2020
%  (elodie.m.lopes@inesctec.pt)
%
%%


switch nargin
    case 0
        disp('Missing input arguments.')
        return;
    case 1
        f=1;
        labels=cell(min(size(EEG)),1);
        for i=1:min(size(EEG))
            labels{i,1}=num2str(i);
        end
        lines=[];
    case 2
        labels=cell(min(size(EEG)),1);
        for i=1:min(size(EEG))
            labels{i,1}=num2str(i);
        end
        lines=[];
    case 3
        lines=[];
end

if size(EEG,1)>size(EEG,2)
   EEG=EEG';
end

time=(1:size(EEG,2))/f;
mi = min(EEG,[],2);
ma = max(EEG,[],2);
shift = cumsum([0; abs(ma(1:end-1))+abs(mi(2:end))]);
shift = repmat(shift,1,size(EEG,2));
hfig=figure; 
plot(time,EEG+shift,'k')
if ~isempty(lines)
    hold on
    for k=1:length(lines)
        line([lines(k),lines(k)],[mi(1)-4,max(max(shift+EEG))+4],...
            'linewidth',2,'color','b')
    end
    hold off
end
set(gca,'ytick',mean(EEG+shift,2),'yticklabel',labels,'fontsize',10)
ylim([mi(1),max(max(shift+EEG))])
xlim([time(1),time(end)])
xlabel('t (s)')

