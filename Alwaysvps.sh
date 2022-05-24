#!/bin/sh
skip=49

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/tmp/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�zu�bmorning.sh �RMS�0��W�����EozG�1�4m�m�I ѩ�ݴEl:�)y���~���>�Ot��J�	�p�R�<�<k)�&b�;��Y��E�����M�k���%�8���A'�!�|�;�x ����	�x0�=��e�s<��;}2�;$�����G�]2�(�<��Lnf�p�n����'2�c(?�@��,�(�%��p���e�\�@ۀ�>퇠�YJe��u?{xj7\JIe��N�ָ��1VT���{i0u�}E�\����E�P?`Tm��K��	)X�-kvc#��=	f6R�o�c7�R�l�D�׮l,W����#T�2�M>�!{A�	NyD��-}��m  