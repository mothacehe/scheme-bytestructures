(cond-expand
 ((library (r6rs bytevectors))
  (export
   int8 uint8 int16 uint16 int32 uint32 int64 uint64
   int16le uint16le int32le uint32le int64le uint64le
   int16be uint16be int32be uint32be int64be uint64be
   float double floatle doublele floatbe doublebe
   ))
 (else
  (export uint8)))
