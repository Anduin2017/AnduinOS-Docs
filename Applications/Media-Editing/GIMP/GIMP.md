# GIMP

GIMP is a free and open-source raster graphics editor used for image retouching and editing, free-form drawing, converting between different image formats, and more specialized tasks.

To install GIMP on AnduinOS, you can run:

```bash
sudo apt update
sudo apt install gimp
```

## Make GIMP works like Photoshop

For some users, GIMP's interface is not as intuitive as Photoshop. You can make GIMP works like Photoshop by installing the [PhotoGIMP plugin](https://github.com/Diolinux/PhotoGIMP). To install PhotoGIMP, you can run:

```bash
cd /tmp
#https://github.com/Diolinux/PhotoGIMP.git
mkdir /tmp/PhotoGIMP
git clone https://github.com/Diolinux/PhotoGIMP.git /tmp/PhotoGIMP
#rsync -Aavx --update --delete /home/anduin/Desktop/PhotoGIMP/.var/app/org.gimp.GIMP/config/GIMP/2.10/ /home/anduin/.config/GIMP/2.10/
rsync -Aavx --update --delete /tmp/PhotoGIMP/.var/app/org.gimp.GIMP/config/GIMP/2.10/ ~/.config/GIMP/2.10/
rm -rf /tmp/PhotoGIMP
```

After installing PhotoGIMP, you can restart GIMP and it will look like Photoshop.
