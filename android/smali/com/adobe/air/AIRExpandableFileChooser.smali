.class public Lcom/adobe/air/AIRExpandableFileChooser;
.super Ljava/lang/Object;
.source "AIRExpandableFileChooser.java"

# interfaces
.implements Landroid/widget/ExpandableListView$OnChildClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AIRExpandableFileChooser$FileChooserExpandableListAdapter;,
        Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;,
        Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;
    }
.end annotation


# static fields
.field private static final FILEINFO:Ljava/lang/String; = "FILEINFO"

.field public static final TAG:Ljava/lang/String;

.field private static final TYPE:Ljava/lang/String; = "TYPE"

.field private static final USER_ACTION_CANCEL:Ljava/lang/String; = "cancel"

.field private static final USER_ACTION_DONE:Ljava/lang/String; = "done"


# instance fields
.field private mAdapter:Landroid/widget/ExpandableListAdapter;

.field private mAllowMultiple:Z

.field private mCheckedFiles:Landroid/util/SparseBooleanArray;

.field private mChildData:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/util/List",
            "<",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;",
            ">;>;>;"
        }
    .end annotation
.end field

.field private mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

.field private mFileChooserStub:Lcom/adobe/air/FileChooserStub;

.field private final mFileProjection:[Ljava/lang/String;

.field private mFileSaveName:Landroid/widget/EditText;

.field private mFilenames:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mGroupData:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field private mMultipleFileSelectionView:Landroid/view/View;

.field private mRuntimeInflater:Landroid/view/LayoutInflater;

.field private mRuntimeResources:Landroid/content/res/Resources;

.field private mSave:Z

.field private mSelection:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 48
    const-class v0, Lcom/adobe/air/AIRExpandableFileChooser;

    invoke-virtual {v0}, Ljava/lang/Class;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/adobe/air/AIRExpandableFileChooser;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/util/ArrayList;ZZLjava/lang/String;Lcom/adobe/air/FileChooserStub;)V
    .locals 17
    .param p2, "save"    # Z
    .param p3, "allowMultiple"    # Z
    .param p4, "defaultName"    # Ljava/lang/String;
    .param p5, "chooserStub"    # Lcom/adobe/air/FileChooserStub;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;ZZ",
            "Ljava/lang/String;",
            "Lcom/adobe/air/FileChooserStub;",
            ")V"
        }
    .end annotation

    .prologue
    .line 274
    .local p1, "filterList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 51
    new-instance v14, Ljava/lang/String;

    invoke-direct {v14}, Ljava/lang/String;-><init>()V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    .line 52
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mMultipleFileSelectionView:Landroid/view/View;

    .line 53
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mAllowMultiple:Z

    .line 54
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSave:Z

    .line 55
    new-instance v14, Landroid/util/SparseBooleanArray;

    invoke-direct {v14}, Landroid/util/SparseBooleanArray;-><init>()V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mCheckedFiles:Landroid/util/SparseBooleanArray;

    .line 56
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFilenames:Ljava/util/ArrayList;

    .line 57
    const/4 v14, 0x2

    new-array v14, v14, [Ljava/lang/String;

    const/4 v15, 0x0

    const-string v16, "_data"

    aput-object v16, v14, v15

    const/4 v15, 0x1

    const-string v16, "_display_name"

    aput-object v16, v14, v15

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileProjection:[Ljava/lang/String;

    .line 60
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

    .line 62
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserStub:Lcom/adobe/air/FileChooserStub;

    .line 64
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    .line 65
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeInflater:Landroid/view/LayoutInflater;

    .line 69
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileSaveName:Landroid/widget/EditText;

    .line 84
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mGroupData:Ljava/util/List;

    .line 85
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mChildData:Ljava/util/List;

    .line 275
    move/from16 v0, p2

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/AIRExpandableFileChooser;->mSave:Z

    .line 276
    move/from16 v0, p3

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/AIRExpandableFileChooser;->mAllowMultiple:Z

    .line 277
    move-object/from16 v0, p5

    move-object/from16 v1, p0

    iput-object v0, v1, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserStub:Lcom/adobe/air/FileChooserStub;

    .line 281
    if-nez p1, :cond_0

    .line 283
    new-instance p1, Ljava/util/ArrayList;

    .end local p1    # "filterList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    invoke-direct/range {p1 .. p1}, Ljava/util/ArrayList;-><init>()V

    .line 284
    .restart local p1    # "filterList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const-string v14, "*"

    move-object/from16 v0, p1

    invoke-virtual {v0, v14}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 286
    :cond_0
    invoke-virtual/range {p1 .. p1}, Ljava/util/ArrayList;->size()I

    move-result v3

    .line 288
    .local v3, "count":I
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_0
    if-ge v8, v3, :cond_1

    .line 290
    move-object/from16 v0, p1

    invoke-virtual {v0, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 292
    .local v7, "filterSpec":Ljava/lang/String;
    const-string v14, "*"

    invoke-virtual {v7, v14}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_4

    .line 294
    const/4 v14, 0x1

    invoke-virtual {v7, v14}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    .line 295
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v14

    if-nez v14, :cond_4

    .line 303
    .end local v7    # "filterSpec":Ljava/lang/String;
    :cond_1
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    .line 305
    .local v2, "activityWrapper":Lcom/adobe/air/AndroidActivityWrapper;
    new-instance v14, Lcom/adobe/air/AndroidAlertDialog;

    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v15

    invoke-direct {v14, v15}, Lcom/adobe/air/AndroidAlertDialog;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

    .line 306
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

    invoke-virtual {v14}, Lcom/adobe/air/AndroidAlertDialog;->GetAlertDialogBuilder()Landroid/app/AlertDialog$Builder;

    move-result-object v4

    .line 307
    .local v4, "dialogBuilder":Landroid/app/AlertDialog$Builder;
    new-instance v14, Lcom/adobe/air/AIRExpandableFileChooser$1;

    move-object/from16 v0, p0

    invoke-direct {v14, v0}, Lcom/adobe/air/AIRExpandableFileChooser$1;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;)V

    invoke-virtual {v4, v14}, Landroid/app/AlertDialog$Builder;->setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)Landroid/app/AlertDialog$Builder;

    .line 319
    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getRuntimeContext()Landroid/content/Context;

    move-result-object v13

    .line 320
    .local v13, "runtimeContext":Landroid/content/Context;
    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v14

    invoke-virtual {v14}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v14

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeInflater:Landroid/view/LayoutInflater;

    .line 321
    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v14

    invoke-virtual {v14}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v14

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    .line 322
    const-string v14, "main"

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeInflater:Landroid/view/LayoutInflater;

    move-object/from16 v16, v0

    invoke-static/range {v14 .. v16}, Lcom/adobe/air/utils/Utils;->GetLayoutView(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/LayoutInflater;)Landroid/view/View;

    move-result-object v10

    .line 324
    .local v10, "layoutView":Landroid/view/View;
    invoke-virtual {v4, v10}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 326
    invoke-virtual {v10}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    .line 328
    .local v9, "layoutResources":Landroid/content/res/Resources;
    const-string v14, "list"

    invoke-static {v14, v9, v10}, Lcom/adobe/air/utils/Utils;->GetWidgetInView(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v14

    check-cast v14, Landroid/widget/ExpandableListView;

    move-object v11, v14

    check-cast v11, Landroid/widget/ExpandableListView;

    .line 330
    .local v11, "list":Landroid/widget/ExpandableListView;
    move-object/from16 v0, p0

    invoke-virtual {v11, v0}, Landroid/widget/ExpandableListView;->setOnChildClickListener(Landroid/widget/ExpandableListView$OnChildClickListener;)V

    .line 332
    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v14

    const v15, 0x1020004

    invoke-virtual {v14, v15}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v14

    invoke-virtual {v11, v14}, Landroid/widget/ExpandableListView;->setEmptyView(Landroid/view/View;)V

    .line 334
    const-string v14, "file_save_panel"

    invoke-static {v14, v9, v10}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/RelativeLayout;

    .line 335
    .local v6, "fileSavePanel":Landroid/widget/RelativeLayout;
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSave:Z

    if-eqz v14, :cond_6

    .line 337
    const-string v14, "file_download"

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    invoke-static {v14, v15}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v4, v14}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 339
    const/4 v14, 0x0

    invoke-virtual {v6, v14}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 341
    const-string v14, "file_save_name"

    invoke-static {v14, v9, v10}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v14

    check-cast v14, Landroid/widget/EditText;

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileSaveName:Landroid/widget/EditText;

    .line 343
    if-eqz p4, :cond_2

    .line 344
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileSaveName:Landroid/widget/EditText;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/adobe/air/utils/Utils;->GetExternalStorageDirectory()Ljava/lang/String;

    move-result-object v16

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    const-string v16, "/"

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    move-object/from16 v0, p4

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 346
    :cond_2
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileSaveName:Landroid/widget/EditText;

    new-instance v15, Lcom/adobe/air/AIRExpandableFileChooser$2;

    move-object/from16 v0, p0

    invoke-direct {v15, v0}, Lcom/adobe/air/AIRExpandableFileChooser$2;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;)V

    invoke-virtual {v14, v15}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    .line 372
    const-string v14, "file_save_button"

    invoke-static {v14, v9, v10}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/Button;

    .line 373
    .local v5, "fileSaveButton":Landroid/widget/Button;
    new-instance v14, Lcom/adobe/air/AIRExpandableFileChooser$3;

    move-object/from16 v0, p0

    invoke-direct {v14, v0}, Lcom/adobe/air/AIRExpandableFileChooser$3;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;)V

    invoke-virtual {v5, v14}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 398
    .end local v5    # "fileSaveButton":Landroid/widget/Button;
    :goto_1
    const-string v14, "audio_files"

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    invoke-static {v14, v15}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v14

    sget-object v15, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    move-object/from16 v0, p0

    invoke-direct {v0, v14, v15}, Lcom/adobe/air/AIRExpandableFileChooser;->AddMediaSubtree(Ljava/lang/String;Landroid/net/Uri;)V

    .line 399
    const-string v14, "image_files"

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    invoke-static {v14, v15}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v14

    sget-object v15, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    move-object/from16 v0, p0

    invoke-direct {v0, v14, v15}, Lcom/adobe/air/AIRExpandableFileChooser;->AddMediaSubtree(Ljava/lang/String;Landroid/net/Uri;)V

    .line 400
    const-string v14, "video_files"

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    invoke-static {v14, v15}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v14

    sget-object v15, Landroid/provider/MediaStore$Video$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    move-object/from16 v0, p0

    invoke-direct {v0, v14, v15}, Lcom/adobe/air/AIRExpandableFileChooser;->AddMediaSubtree(Ljava/lang/String;Landroid/net/Uri;)V

    .line 402
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mGroupData:Ljava/util/List;

    invoke-interface {v14}, Ljava/util/List;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_7

    .line 404
    new-instance v14, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserExpandableListAdapter;

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeInflater:Landroid/view/LayoutInflater;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    move-object/from16 v16, v0

    move-object/from16 v0, p0

    move-object/from16 v1, v16

    invoke-direct {v14, v0, v15, v1}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserExpandableListAdapter;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;Landroid/view/LayoutInflater;Landroid/content/res/Resources;)V

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mAdapter:Landroid/widget/ExpandableListAdapter;

    .line 405
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mAdapter:Landroid/widget/ExpandableListAdapter;

    invoke-virtual {v11, v14}, Landroid/widget/ExpandableListView;->setAdapter(Landroid/widget/ExpandableListAdapter;)V

    .line 406
    const/4 v14, 0x1

    invoke-virtual {v11, v14}, Landroid/widget/ExpandableListView;->setItemsCanFocus(Z)V

    .line 407
    const-string v14, "empty"

    invoke-static {v14, v9, v10}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v14

    check-cast v14, Landroid/widget/TextView;

    move-object v12, v14

    check-cast v12, Landroid/widget/TextView;

    .line 408
    .local v12, "noFileTextView":Landroid/widget/TextView;
    const/16 v14, 0x8

    invoke-virtual {v12, v14}, Landroid/widget/TextView;->setVisibility(I)V

    .line 415
    .end local v12    # "noFileTextView":Landroid/widget/TextView;
    :goto_2
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mAllowMultiple:Z

    if-eqz v14, :cond_3

    .line 416
    invoke-direct/range {p0 .. p0}, Lcom/adobe/air/AIRExpandableFileChooser;->createInvisibleMultipleFileSelectionView()V

    .line 417
    :cond_3
    return-void

    .line 298
    .end local v2    # "activityWrapper":Lcom/adobe/air/AndroidActivityWrapper;
    .end local v4    # "dialogBuilder":Landroid/app/AlertDialog$Builder;
    .end local v6    # "fileSavePanel":Landroid/widget/RelativeLayout;
    .end local v9    # "layoutResources":Landroid/content/res/Resources;
    .end local v10    # "layoutView":Landroid/view/View;
    .end local v11    # "list":Landroid/widget/ExpandableListView;
    .end local v13    # "runtimeContext":Landroid/content/Context;
    .restart local v7    # "filterSpec":Ljava/lang/String;
    :cond_4
    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    invoke-virtual {v14}, Ljava/lang/String;->length()I

    move-result v14

    if-eqz v14, :cond_5

    .line 299
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " OR "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    .line 300
    :cond_5
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "_display_name LIKE \'%"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, "\'"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object/from16 v0, p0

    iput-object v14, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    .line 288
    add-int/lit8 v8, v8, 0x1

    goto/16 :goto_0

    .line 395
    .end local v7    # "filterSpec":Ljava/lang/String;
    .restart local v2    # "activityWrapper":Lcom/adobe/air/AndroidActivityWrapper;
    .restart local v4    # "dialogBuilder":Landroid/app/AlertDialog$Builder;
    .restart local v6    # "fileSavePanel":Landroid/widget/RelativeLayout;
    .restart local v9    # "layoutResources":Landroid/content/res/Resources;
    .restart local v10    # "layoutView":Landroid/view/View;
    .restart local v11    # "list":Landroid/widget/ExpandableListView;
    .restart local v13    # "runtimeContext":Landroid/content/Context;
    :cond_6
    const-string v14, "file_upload"

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    invoke-static {v14, v15}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v4, v14}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 396
    const/16 v14, 0x8

    invoke-virtual {v6, v14}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    goto/16 :goto_1

    .line 412
    :cond_7
    const/16 v14, 0x8

    invoke-virtual {v11, v14}, Landroid/widget/ExpandableListView;->setVisibility(I)V

    goto :goto_2
.end method

.method private AddMediaSubtree(Ljava/lang/String;Landroid/net/Uri;)V
    .locals 11
    .param p1, "groupName"    # Ljava/lang/String;
    .param p2, "groupUri"    # Landroid/net/Uri;

    .prologue
    const/4 v4, 0x0

    .line 545
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v0

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileProjection:[Ljava/lang/String;

    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    .line 548
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_2

    move-object v3, v4

    :goto_0
    move-object v1, p2

    move-object v5, v4

    .line 545
    invoke-virtual/range {v0 .. v5}, Landroid/app/Activity;->managedQuery(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 550
    .local v6, "childCursor":Landroid/database/Cursor;
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    .line 551
    .local v7, "children":Ljava/util/List;, "Ljava/util/List<Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;>;"
    if-eqz v6, :cond_1

    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 553
    new-instance v9, Ljava/util/HashMap;

    invoke-direct {v9}, Ljava/util/HashMap;-><init>()V

    .line 554
    .local v9, "groupMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v0, "TYPE"

    invoke-interface {v9, v0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 555
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mGroupData:Ljava/util/List;

    invoke-interface {v0, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 559
    :cond_0
    new-instance v10, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;

    const-string v0, "_display_name"

    .line 560
    invoke-interface {v6, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    const-string v1, "_data"

    .line 561
    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v10, p0, v0, v1}, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;Ljava/lang/String;Ljava/lang/String;)V

    .line 562
    .local v10, "info":Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;
    new-instance v8, Ljava/util/HashMap;

    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    .line 563
    .local v8, "curChildMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    invoke-interface {v7, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 564
    const-string v0, "FILEINFO"

    invoke-interface {v8, v0, v10}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 565
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-nez v0, :cond_0

    .line 567
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mChildData:Ljava/util/List;

    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 569
    .end local v8    # "curChildMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    .end local v9    # "groupMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v10    # "info":Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;
    :cond_1
    return-void

    .line 548
    .end local v6    # "childCursor":Landroid/database/Cursor;
    .end local v7    # "children":Ljava/util/List;, "Ljava/util/List<Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;>;"
    :cond_2
    iget-object v3, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mSelection:Ljava/lang/String;

    goto :goto_0
.end method

.method private HideVirtualKeyboard(Landroid/view/View;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 573
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "input_method"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 574
    .local v0, "imm":Landroid/view/inputmethod/InputMethodManager;
    if-eqz v0, :cond_0

    .line 576
    invoke-virtual {p1}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 578
    :cond_0
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/AIRExpandableFileChooser;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-boolean v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mAllowMultiple:Z

    return v0
.end method

.method static synthetic access$100(Lcom/adobe/air/AIRExpandableFileChooser;II)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;
    .param p1, "x1"    # I
    .param p2, "x2"    # I

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/AIRExpandableFileChooser;->expandableListPositionToFlatPosition(II)I

    move-result v0

    return v0
.end method

.method static synthetic access$1000(Lcom/adobe/air/AIRExpandableFileChooser;)Lcom/adobe/air/AndroidAlertDialog;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/widget/ExpandableListAdapter;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mAdapter:Landroid/widget/ExpandableListAdapter;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/adobe/air/AIRExpandableFileChooser;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/adobe/air/AIRExpandableFileChooser;->uncheckAll()V

    return-void
.end method

.method static synthetic access$300(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/util/SparseBooleanArray;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mCheckedFiles:Landroid/util/SparseBooleanArray;

    return-object v0
.end method

.method static synthetic access$400(Lcom/adobe/air/AIRExpandableFileChooser;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mChildData:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$500(Lcom/adobe/air/AIRExpandableFileChooser;)Ljava/util/List;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mGroupData:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$600(Lcom/adobe/air/AIRExpandableFileChooser;)Lcom/adobe/air/FileChooserStub;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserStub:Lcom/adobe/air/FileChooserStub;

    return-object v0
.end method

.method static synthetic access$700(Lcom/adobe/air/AIRExpandableFileChooser;)Landroid/widget/EditText;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileSaveName:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$800(Lcom/adobe/air/AIRExpandableFileChooser;)Ljava/util/ArrayList;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;

    .prologue
    .line 46
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFilenames:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$900(Lcom/adobe/air/AIRExpandableFileChooser;Landroid/view/View;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AIRExpandableFileChooser;
    .param p1, "x1"    # Landroid/view/View;

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/adobe/air/AIRExpandableFileChooser;->HideVirtualKeyboard(Landroid/view/View;)V

    return-void
.end method

.method private createInvisibleMultipleFileSelectionView()V
    .locals 3

    .prologue
    .line 506
    iget-object v1, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

    invoke-virtual {v1}, Lcom/adobe/air/AndroidAlertDialog;->GetAlertDialogBuilder()Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 507
    .local v0, "dialogBuilder":Landroid/app/AlertDialog$Builder;
    const-string v1, "button_ok"

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    invoke-static {v1, v2}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/adobe/air/AIRExpandableFileChooser$4;

    invoke-direct {v2, p0}, Lcom/adobe/air/AIRExpandableFileChooser$4;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 531
    const-string v1, "button_cancel"

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mRuntimeResources:Landroid/content/res/Resources;

    invoke-static {v1, v2}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/adobe/air/AIRExpandableFileChooser$5;

    invoke-direct {v2, p0}, Lcom/adobe/air/AIRExpandableFileChooser$5;-><init>(Lcom/adobe/air/AIRExpandableFileChooser;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 539
    return-void
.end method

.method private expandableListPositionToFlatPosition(II)I
    .locals 3
    .param p1, "groupPosition"    # I
    .param p2, "childPosition"    # I

    .prologue
    const/4 v0, -0x1

    .line 464
    if-ltz p1, :cond_0

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mChildData:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-lt p1, v2, :cond_1

    .line 480
    :cond_0
    :goto_0
    return v0

    .line 469
    :cond_1
    if-ltz p2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mChildData:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge p2, v2, :cond_0

    .line 475
    const/4 v0, 0x0

    .line 476
    .local v0, "flatPosition":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    if-ge v1, p1, :cond_2

    .line 477
    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mChildData:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    add-int/2addr v0, v2

    .line 476
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 478
    :cond_2
    add-int/2addr v0, p2

    .line 480
    goto :goto_0
.end method

.method private uncheckAll()V
    .locals 7

    .prologue
    .line 486
    iget-boolean v6, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mAllowMultiple:Z

    if-nez v6, :cond_1

    .line 501
    :cond_0
    return-void

    .line 489
    :cond_1
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mGroupData:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v5

    .line 490
    .local v5, "numGroups":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v5, :cond_0

    .line 492
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mChildData:Ljava/util/List;

    invoke-interface {v6, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v4

    .line 493
    .local v4, "numChildren":I
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_1
    if-ge v3, v4, :cond_3

    .line 495
    iget-object v6, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mAdapter:Landroid/widget/ExpandableListAdapter;

    invoke-interface {v6, v1, v3}, Landroid/widget/ExpandableListAdapter;->getChild(II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/HashMap;

    .line 496
    .local v0, "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    const-string v6, "FILEINFO"

    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;

    iget-object v2, v6, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;->mParent:Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    .line 497
    .local v2, "item":Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;
    if-eqz v2, :cond_2

    .line 498
    invoke-virtual {v2}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->uncheck()V

    .line 493
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 490
    .end local v0    # "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    .end local v2    # "item":Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method


# virtual methods
.method public GetDialog()Lcom/adobe/air/AndroidAlertDialog;
    .locals 1

    .prologue
    .line 582
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

    return-object v0
.end method

.method public GetFileNames()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 587
    iget-object v0, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFilenames:Ljava/util/ArrayList;

    return-object v0
.end method

.method public onChildClick(Landroid/widget/ExpandableListView;Landroid/view/View;IIJ)Z
    .locals 4
    .param p1, "parent"    # Landroid/widget/ExpandableListView;
    .param p2, "view"    # Landroid/view/View;
    .param p3, "groupPosition"    # I
    .param p4, "childPosition"    # I
    .param p5, "id"    # J

    .prologue
    .line 422
    instance-of v2, p2, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    if-nez v2, :cond_0

    .line 423
    const/4 v2, 0x0

    .line 459
    :goto_0
    return v2

    :cond_0
    move-object v1, p2

    .line 425
    check-cast v1, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;

    .line 439
    .local v1, "item":Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;
    iget-boolean v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mAllowMultiple:Z

    if-nez v2, :cond_2

    .line 441
    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mAdapter:Landroid/widget/ExpandableListAdapter;

    invoke-interface {v2, p3, p4}, Landroid/widget/ExpandableListAdapter;->getChild(II)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/HashMap;

    .line 442
    .local v0, "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    iget-boolean v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mSave:Z

    if-eqz v2, :cond_1

    .line 444
    iget-object v3, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileSaveName:Landroid/widget/EditText;

    const-string v2, "FILEINFO"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;

    iget-object v2, v2, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;->mFilePath:Ljava/lang/String;

    invoke-virtual {v3, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 459
    .end local v0    # "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    :goto_1
    const/4 v2, 0x1

    goto :goto_0

    .line 448
    .restart local v0    # "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    :cond_1
    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFilenames:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 449
    iget-object v3, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFilenames:Ljava/util/ArrayList;

    const-string v2, "FILEINFO"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;

    iget-object v2, v2, Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;->mFilePath:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 451
    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserStub:Lcom/adobe/air/FileChooserStub;

    const-string v3, "done"

    invoke-virtual {v2, v3}, Lcom/adobe/air/FileChooserStub;->SetUserAction(Ljava/lang/String;)V

    .line 452
    iget-object v2, p0, Lcom/adobe/air/AIRExpandableFileChooser;->mFileChooserDialog:Lcom/adobe/air/AndroidAlertDialog;

    invoke-virtual {v2}, Lcom/adobe/air/AndroidAlertDialog;->dismiss()V

    goto :goto_1

    .line 457
    .end local v0    # "child":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/air/AIRExpandableFileChooser$FileInfo;>;"
    :cond_2
    invoke-virtual {v1}, Lcom/adobe/air/AIRExpandableFileChooser$FileChooserItem;->toggle()V

    goto :goto_1
.end method
