function isplay = testTime(T, Tmax)

if nargin == 1
    Tmax = 15;
end

if T > Tmax
    reply = input(sprintf('Are you really want to play %.1f seconds of sound? Y/N [N]:', T), 's');
   if isempty(reply)
      reply = 'N';
   end
   
   if upper(reply) == 'N'
       fprintf('SoundCW is terminated by user!\n');
       isplay = 0;
       return;
   elseif upper(reply) == 'Y';
       fprintf('SoundCW will sound for %.1f seconds!\n', T);
       isplay = 1;
       return;
   end
else
    isplay = 1;
end

end % testTime(T)
