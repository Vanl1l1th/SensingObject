SerialPort.devices;
s.boot;
s.quit;
~port= SerialPort.new("/dev/cu.HC-06-DevB",9600);
b = NetAddr.new("127.0.0.1", 12000);
~tVal2=0; ~tVal=0; ~tVal3=0; ~tVal4=0;~note=0;
~port.read;


(
~inArray=[];
~getVal=Routine.new({
	var in;
	{
		in=~port.read.asAscii;
		if(in.isDecDigit,{~inArray=~inArray.add(in)});
		if(in==$a,{
			~xVal=~inArray.collect(_.digit).convertDigits;
			~inArray=[];
		});
		if(in==$b,{
			~yVal=~inArray.collect(_.digit).convertDigits;
			~inArray=[];
		});
		if(in==$c,{
			~zVal=~inArray.collect(_.digit).convertDigits;
			~inArray=[];
		});
		if(in==$d,{
			~tVal=~inArray.collect(_.digit).convertDigits;
			~inArray=[];
		});
		if(in==$e,{
			~tVal2=~inArray.collect(_.digit).convertDigits;
			~inArray=[];
		});
		if(in==$f,{
			~tVal3=~inArray.collect(_.digit).convertDigits;
			~inArray=[];
		});
		if(in==$g,{
			~tVal4=~inArray.collect(_.digit).convertDigits;
			~inArray=[];
		});
		b.sendMsg("/gyr",~xVal,~yVal,~note.asInteger);

		if(~tVal>250,{
			b.sendMsg("/touch1",1);
		});
		if(~tVal2>50,{
			b.sendMsg("/touch2",1);
		});
		if(~tVal3>50,{
			b.sendMsg("/touch3",1);
		});
		if(~tVal3>50,{
			b.sendMsg("/touch4",1);
		});
	}.loop;
}).play;
)


(
SynthDef.new(\s1,{|inte = 9, width=0.5|
	var sig1;
	sig1={GVerb.ar((Saw.ar([10,9])*Saw.ar([20,19])**Saw.ar([28,35]*Saw.ar(4)/4+0.25)/inte).clip(-1,1))/4};
	Out.ar(0,sig1);
}).add;

~synth1=Synth.newPaused(\s1);
~synth2=Synth.newPaused(\s1);
)


SynthDef.new(\atmo,{|freq = 100, width=100|

	var sig1= RLPF.ar(Pulse.ar([freq,freq+200], 0.1, 0.1), SinOsc.kr(0.4).range(width,width+150),0.03,5);
	Out.ar(0,sig1);
	//Out.ar(1,sig2);
}).add;
~atmo1=Synth.newPaused(\atmo);
~atmo1.run(true);
~atmo1.set(\width,300);
~atmo1.run(false);

(
~control=Routine.new({
	{

		//~atmo1.set(\width,~zVal.linlin(5000,16000,200,600));
		~atmo1.set(\freq,~yVal.linlin(500,15000,100,800));

		~note=~yVal.linlin(500,15000,25,0);

		if(~tVal>500,{
			~synth1.run(true);
			~synth1.set(\inte,~zVal.linlin(500,13000,1,18));
		});
		if(~tVal<=500,{
			~synth1.run(false);
		});

		if(~tVal2>500,{
			~synth2.run(true);
			~synth2.set(\inte,~yVal.linlin(500,15000,1,18));
		});
		if(~tVal2<=500,{
			~synth2.run(false);
		});

		//~synth1.set(\freq,~yVal.linexp(500,15000,30,500));
	0.01.wait;
	}.loop;
}).play;
)

~getVal.stop;
~control.stop;
~synth1.free;

~note.asInteger
~tVal;
~tVal2;
~tVal3;
~tVal4;
~xVal;
~yVal;
~zVal;

~port.close;
s.quit;