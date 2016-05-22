function y = soundCW(freq, T, A, Fs, nBit)

if nargin == 1
    T = 1;
    Fs = 44100;
    A = 1;
    nBit = 24;
elseif nargin == 2
    A = 1;
    Fs = 44100;
    nBit = 24;
elseif nargin == 3
    Fs = 44100;
    nBit = 24;
elseif nargin == 4
    nBit = 24;
elseif nargin <1 || nargin > 5
    error('SOUNDCW: wrong argument number');
end

if A > 1
    A = 1;
end

if ~testSoundPlayTime(T)
    return;
end

Ts = 1/Fs;
t = 0:Ts:T;

if length(A) == 1
    Y1 = A.*sin(2*pi*freq.*t);
    Y2 = Y1;
else
    Y1 = A(1).*sin(2*pi*freq.*t);
    Y2 = A(2).*sin(2*pi*freq.*t);
end

y = [Y1;Y2];

sound(y, Fs, nBit);

end