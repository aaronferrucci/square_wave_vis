# square_wave_vis
Visualize sum of sinusoids synthesis of a square wave.

How-to:
  1. Run square_wave_vis.pde in the Processing IDE to generate the draw-###.png
     files
  2. png2yuv -I p -f 30 -b 1 -n 629 -j draw-%04d.png > draw.yuv
  3. vpxenc --good --cpu-used=0 --auto-alt-ref=1 --lag-in-frames=16 --passes=2 --threads=2 --target-bitrate=3000 -o square_wave_vis.webm draw.yuv
  4. Upload the webm file to gfycat.com

https://gfycat.com/SpiritedBountifulAcaciarat

