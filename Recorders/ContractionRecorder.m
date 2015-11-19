function ContractionRecorder
%CONTRACTION RECORDER
%   ContractionRecorder is written to record the contraction time and
%   interval for a parturient who is about to give birth. The regular
%   uterine contraction indicates the family should prepared to go to
%   hospital at any time when the contraction intervals meet the
%   requirement that you have to action.
%
%   Using the program is easy, just RUN and press ANY KEY while record the
%   start time and stop time of one contraction.

%   Written by dovecho at GMAIL dot COM
%   File name: ContractionRecorder.m
%   Revision Note: First publish of the program
%   $Version: 1.0.0.2 $	$Date: 2015-11-19 21:15:15 $

% Recording
recordFName = sprintf('REC_CONTRACTION_%s.txt', datestr(now, 'yyyy-mm-dd'));
diary(recordFName);

% set clean up function, to close diary while force excuting
% ref: http://cn.mathworks.com/help/matlab/ref/oncleanup.html
diaryclearnup = onCleanup(@() set(0,'Diary','off'));

strWait1 = 'Press ANY KEY when contraction STARTS... ';
strWait2 = 'Press ANY KEY when contraction STOPS... ';

% The program can be terminated by CTRL+C at any time, if needed. Just
% leave the MATLAB open, and the program can be runned again, and the
% contraction data are saved in the global varibles. 
global iContractionRecorderCount;
global tContractionRecorder;

if isempty(iContractionRecorderCount)
%   For a fresh start of recording
    iContractionRecorderCount = 1;
    tContractionRecorder = 0;
    
    % Welcome message
    fprintf('Welcome to CONTRACTION RECORDER!\n');
    fprintf('======================================\n');
    fprintf('WARNING!!! Be prepared for delivery before using this program!!\n\n')
    fprintf('When contraction interval meets the requirement to go to the hospital,\n');
    fprintf('GO at ease, and good luck!\n\n');
    fprintf('NOTE1: Press CTRL+C to terminate the recording.\n');
    fprintf('NOTE2: You can run the program again to continue recording.\n');
    fprintf('NOTE3: Run CLEAR ALL to reset the recording.\n\n');
    fprintf('RECORDING STARTS AT: %s\n', datestr(now));
    fprintf('=======================================================\n');
end

% Display information while waiting a contraction starts
diary off;fprintf('%s\n', strWait1);pause;diary on;

% Start timing of contraction
tic;

% Main loop
while 1
    % Record the starting time of a contraction
    diary off;fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b');diary on;
    strStartTime = datestr(now, 'HH:MM:SS'); 
    dt = toc+tContractionRecorder; % DT is the time interval between two contractions
    
    fprintf('No. %3d Starts at: %s, ', iContractionRecorderCount, strStartTime);
    if iContractionRecorderCount > 1
        fprintf('Interval: %02d:%02d, ', floor(dt/60), mod(round(dt),60));
    end
    
    % Wait for contraction ends
    tic;
    diary off;fprintf('\n%s', strWait2);diary on;
    pause;
    
    % Contraction ends
    diary off;fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b');diary on;
    strEndTime =  datestr(now);
    tContractionRecorder = toc;
    fprintf('Last: %d sec.\n', round(tContractionRecorder));
    
    % Wait for next contraction starts
    tic;
    iContractionRecorderCount = iContractionRecorderCount + 1;
    
    diary off;fprintf('%s\n', strWait1);pause;diary on;
end

diary off;