function y = soundLAM(freq, Astart, Astop, T, Fs, nBit)

if nargin == 3
    T = 1;
    Fs = 44100;
    nBit = 24;
elseif nargin == 4
    Fs = 44100;
    nBit = 24;
elseif nargin == 5
    nBit = 24;
elseif nargin <3 || nargin > 6
    error('SOUNDLAM: wrong argument number');
end


if ~testSoundPlayTime(T)
    return;
end

Ts = 1/Fs;
t = 0:Ts:T;

if (sum(Astart) <= 0) & (sum(Astop) <= 0) % in dB Unit
    a = Astart'*ones(size(t)) + (Astop - Astart)'./T*t;
    A = db2mag(a);
elseif (sum(Astart) > 0) & (sum(Astop) > 0)
    A = Astart'*ones(size(t)) + (Astop - Astart)'./T*t;
else
    error('SOUNDLAM: ASTART and ASTOP should have the same sign!');
end

f = freq;

Y1 = A(1,:).*sin(2*pi*f.*t);
Y2 = A(2,:).*sin(2*pi*f.*t);

y = [Y1;Y2];


sound(y, Fs, nBit);