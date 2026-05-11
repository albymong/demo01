# AGENTS.md – 레포지토리 운영 가이드

## 📌 핵심 목표
- 에이전트가 레포지토리 구조, 명령어 흐름, 특수 규칙 등을 빠르게 파악하도록 합니다.
- “에이전트가 놓칠 가능성이 높은” 항목만 포함하고, 그 외 일반적인 내용은 제외합니다.

---

## 1️⃣ 레포지토리 구조와 주요 진입점
- **루트 디렉터리**: `src/` 가 주요 코드베이스이며, 실행 가능한 진입점은 `src/index.js` (또는 `src/index.ts`) 입니다.
- **테스트**: `tests/` 디렉터리 아래에 위치. Jest 사용 (`npm test`).
- **빌드**: `scripts/build.js` 가 프로젝트 빌드 스크립트이며, `npm run build` 로 호출됩니다.

---

## 2️⃣ 필수 개발 명령어
| 목적 | 명령어 | 비고 |
|------|--------|------|
| 의존성 설치 | `npm install` | `package-lock.json` 과 동기화 |
| 전체 테스트 실행 | `npm test` | Jest 설정은 `jest.config.js` 에 정의 |
| 개별 테스트 실행 | `npm test -- -t "<테스트 이름>"` | 테스트 이름 부분에 문자열 매칭 |
| 코드 포맷팅 | `npm run fmt` | `prettier` 사용 |
| 린트 검사 | `npm run lint` | `eslint` 실행 (자동 수정 포함: `npm run lint -- --fix`) |
| 타입 체크 (TypeScript) | `npm run typecheck` | `tsc --noEmit` |
| 빌드 | `npm run build` | `scripts/build.js` 실행 후 `dist/` 생성 |

> **주의**: `lint → typecheck → test` 순서대로 실행하면 CI와 동일한 검증 흐름을 재현할 수 있습니다.

---

## 3️⃣ CI / 프리커밋 훅
- **GitHub Actions**: `.github/workflows/ci.yml` 에 정의. 주요 단계는 `install → lint → typecheck → test → build`.
- **pre-commit**: `.pre-commit-config.yaml` 사용, `eslint`, `prettier`, `stylelint` 자동 실행.

> 에이전트는 로컬에서 위와 같은 흐름을 재현해야 PR 검증 시 오류를 방지합니다.

---

## 4️⃣ 특수 설정 / 환경 변수
- **환경 파일**: `.env.example` 을 복사해 `.env` 로 만들고, `dotenv` 로 로드합니다.
- **Node 버전**: `package.json` 의 `engines.node` 가 `>=18` 이며, `nvm use` 로 환경 통일 권장.

---

## 5️⃣ 테스트 특이사항
- **통합 테스트**는 Docker 기반 데이터베이스가 필요합니다. `npm run test:integration` 은 `docker-compose up -d` 를 자동 실행합니다.
- **스냅샷 테스트**는 `__snapshots__/` 디렉터리에 저장됩니다. 스냅샷 업데이트는 `npm test -- -u` 로 수행.

---

## 6️⃣ 코드 생성·마이그레이션
- **코드 생성**: `npm run codegen` 은 `graphql-codegen` 을 실행해 `src/generated/` 디렉터리에 파일을 생성합니다.
- **마이그레이션**: `npm run migrate` 로 `prisma` 마이그레이션을 적용합니다. DB 초기화는 `npm run migrate:reset` 사용.

---

## 7️⃣ 스타일·규칙
- **ESLint**: `eslint-config-custom` 을 베이스로 사용. 프로젝트 전역 변수는 `globals` 에 명시.
- **Prettier**: `.prettierrc` 에 맞춰 자동 포맷팅. 커밋 전 반드시 `npm run fmt` 실행 권장.
- **타입스크립트**: `tsconfig.json` 에 `strict:true` 가 기본이며, `noImplicitAny` 가 활성화돼 있습니다.

---

## 8️⃣ 흔히 놓치는 점
- **핵심 명령어** (`npm run lint -- --fix`) 에 `--` 뒤 옵션을 붙여야 `npm` 스크립트에 전달됩니다.
- **CI에서 실패** 하는 경우, 로컬에서 **전체 흐름** (`npm run lint && npm run typecheck && npm test && npm run build`) 을 순서대로 실행해 원인 파악.
- **패키지 경로**: `src/` 내부 절대 경로(import alias) 은 `tsconfig.json` 의 `paths` 로 설정돼 있어, VSCode에서 자동 완성됩니다.

---

## 9️⃣ 문서·추가 자료
- `README.md` – 프로젝트 전반 개요 및 시작 가이드.
- `CONTRIBUTING.md` – PR 프로세스와 리뷰 체크리스트.
- `opencode.json` – OpenCode 전용 설정 (설정 파일 위치, 명령어 별 alias 등).

---

*이 파일은 에이전트가 레포지토리를 빠르게 파악하고, 흔히 놓치는 중요한 단계와 명령어를 제공하도록 설계되었습니다. 필요에 따라 최신 정보를 반영해 업데이트하세요.*