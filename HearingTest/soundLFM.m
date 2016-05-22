function y = soundLFM(fstart, fstop, T, A, Fs, nBit)

if nargin == 2
    T = 1;
    Fs = 44100;
    A = 1;
    nBit = 24;
elseif nargin == 3
    A = 1;
    Fs = 44100;
    nBit = 24;
elseif nargin == 4
    Fs = 44100;
    nBit = 24;
elseif nargin == 5
    nBit = 24;
elseif nargin <2 || nargin > 6
    error('SOUNDLFM: wrong argument number');
end

if A > 1
    A = 1;
end

if ~testSoundPlayTime(T)
    return;
end

Ts = 1/Fs;
t = 0:Ts:T;

f = fstart + (fstop-fstart) / T .* t;

Y1 = A.*sin(2*pi*f.*t);
Y2 = A.*sin(2*pi*f.*t);

y = [Y1;Y2];


sound(y, Fs, nBit);