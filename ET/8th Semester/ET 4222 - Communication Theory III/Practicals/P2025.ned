//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package p2025;

import ned.IdealChannel;
import org.omnetpp.queueing.Source;
import org.omnetpp.queueing.Queue;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.PassiveQueue;
import org.omnetpp.queueing.Server;
import org.omnetpp.queueing.Delay;

//
// TODO Generated network
//
network P2025
{
    @display("bgb=665,322");
    submodules:
        source: Source {
            @display("p=50,50");
        }
        server: Queue {
            @display("p=150,50");
        }
        sink: Sink {
            @display("p=250,50");
        }
        source1: Source {
            @display("p=121,167");
        }
    connections:
        source.out --> server.in++;
        server.out --> sink.in++;
        source1.out --> IdealChannel --> server.in++;
}
