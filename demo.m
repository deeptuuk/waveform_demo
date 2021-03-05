clc
clear all
Client = tcpip('0.0.0.0', 30000, 'NetworkRole', 'server');
fopen(Client);
hold on
plot(0, 0);
ylim([-1.5 1.5]);
buffer = zeros(1, 1000, 'double');
while 1
    Client.BytesAvailable
    data = swapbytes(fread(Client, 20, 'double'));
    buffer = circshift(buffer, -20, 2);
    for i = 981:1000
       buffer(i) = data(i-980);
    end
    clf
    plot(buffer);
    ylim([-1.5 1.5]);
    drawnow;
end
hold off