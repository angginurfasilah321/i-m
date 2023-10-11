-- name: CreateTenant :one
INSERT INTO "Tenant" (
  "location_uuid",
  "category_uuid",
  "name",
  "area_size",
  "bottom_rate_per_month",
  "revenue_sharing_percentage"
) VALUES (
  $1, $2, $3, $4, $5, $6
) RETURNING *;

-- name: GetTenant :one
SELECT * FROM "Tenant"
WHERE uuid = $1 LIMIT 1;

-- name: GetTenantForUpdate :one
SELECT * FROM "Tenant"
WHERE uuid = $1 LIMIT 1
FOR NO KEY UPDATE;

-- name: ListTenant :many
SELECT * FROM "Tenant"
WHERE name = $1
ORDER BY uuid
LIMIT $2
OFFSET $3;

-- name: DeleteTenant :exec
DELETE FROM "Tenant"
WHERE uuid = $1;

-- name: UpdateTenant :one
UPDATE "Tenant" SET
  "location_uuid" = $1,
  "category_uuid" = $2,
  "name" = $3,
  "area_size" = $4,
  "bottom_rate_per_month" = $5,
  "revenue_sharing_percentage" = $6
WHERE "uuid" = $7
RETURNING *;