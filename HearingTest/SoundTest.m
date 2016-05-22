f = 18000;
T = 10;
a0 = 0;
a1 = -100;


fprintf('======== Sound Test of Listen Threshold ========\n');
Tstart = now;

fprintf('==== STEP 1: Both ears test ========\n');
input('Press ENTER to start test, then press ENTER when you CANNOT hear anything... \n');
soundLAM(f, [a0 a0], [a1 a1], T);
tic;
input(sprintf('f = %d Hz: ', f));
LT = toc - 0.1;
rsp2 = (a1-a0)/T*LT;
fprintf('Listening threshold of both ear at %d Hz is %.2f dB. (%.3f s)\n', f, rsp2, LT);

fprintf('==== STEP 2: Left ear test ========\n');
input('Press ENTER to start a sound, then press ENTER when you CANNOT hear anything... \n');
soundLAM(f, [a0 -100], [ a1, -100], T);
tic;
input(sprintf('f = %d Hz: ', f));
LT = toc - 0.1;
rspL = (a1-a0)/T*LT;
fprintf('Listening threshold of LEFT ear at %d Hz is %.2f dB. (%.3f s)\n', f, rspL, LT);

fprintf('==== STEP 3: Right ear test ========\n');
input('Press ENTER to start a sound, then press ENTER when you CANNOT hear anything... \n');
soundLAM(f, [-100 a0], [-100, a1], T);
tic;
input(sprintf('f = %d Hz: ', f));
LT = toc - 0.1;
rspR = (a1-a0)/T*LT;
fprintf('Listening threshold of RIGHT ear at %d Hz is %.2f dB. (%.3f s)\n', f, rspR, LT);

Tstop = now;
%%
% Display test result
fprintf('\n     =============== EAR TEST SUMMARY ================');  
fprintf('\n --------------------------------------------------------');
fprintf('\n | Test starts on %20s                  |', datestr(Tstart) );
fprintf('\n --------------------------------------------------------');
fprintf('\n | Frequency  | Both ears   | Left ear    | Right ear   |');
fprintf('\n | % 8.1f Hz| % 8.2f dB | % 8.2f dB | % 8.2f dB |', f, rsp2, rspL, rspR);
fprintf('\n --------------------------------------------------------');
fprintf('\n | Test done on %20s                    |', datestr(Tstop) );
fprintf('\n --------------------------------------------------------');
fprintf('\n');
