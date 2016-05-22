f = 440;
T = 10;
a0 = -8
a1 = 0;


fprintf('======== Sound Test of Listen Threshold ========\n');
Tstart = now;


freq = [200 400 800 1600];
for ifreq = 1 : length(freq);
    f = freq(ifreq);
    fprintf('======== Test on %.1f Hz ========\n', f);
    
    fprintf('==== STEP 1: Both ears test ========\n');
    input('Press SPACE to start test, then press ENTER when you HEAR anything... ');
    soundLAM(f, [a0 a0], [a1 a1], T);
    tic;
    pause;
    LT = toc - 0.1;
    rsp(1, ifreq) = (a1-a0)/T*LT;

    fprintf('==== STEP 2: Left ear test ========\n');
    input('Press SPACE to start test, then press ENTER when you HEAR anything... ');
    soundLAM(f, [a0 a0], [a1 a1], T);
    tic;
    pause;
    LT = toc - 0.1;
    rsp(2, ifreq) = (a1-a0)/T*LT;

    fprintf('==== STEP 3: Right ear test ========\n');
    input('Press SPACE to start test, then press ENTER when you HEAR anything... ');
    soundLAM(f, [a0 a0], [a1 a1], T);
    tic;
    pause;
    LT = toc - 0.1;
    rsp(3, ifreq) = (a1-a0)/T*LT;

    Tstop = now;
end
%%
% Display test result
fprintf('\n     =============== EAR TEST SUMMARY ================');  
fprintf('\n --------------------------------------------------------');
fprintf('\n | Test starts on %20s                  |', datestr(Tstart) );
fprintf('\n --------------------------------------------------------');
fprintf('\n | Frequency  | Both ears   | Left ear    | Right ear   |');
for ifreq = 1 : length(freq)
    fprintf('\n | % 8.1f Hz| % 8.2f dB | % 8.2f dB | % 8.2f dB |', freq(ifreq),...
        rsp(1,ifreq), rsp(2, ifreq), rsp(3, ifreq));
end
fprintf('\n --------------------------------------------------------');
fprintf('\n | Test done on %20s                    |', datestr(Tstop) );
fprintf('\n --------------------------------------------------------');
fprintf('\n');
